Module = inherit(Object)

function Module:constructor(path)
    ModuleManager:getSingleton():addRef(self)
    self.m_Name = path:gsub("/", "")
    self.m_Path = transformModulePath(path)
    self.m_Loader = ModuleLoader:new(self)

    local status, err = self.m_Loader:addFiles(self:parseMeta())
    if status then
        self.m_Loader.m_SandboxLoader()
        assert(_G["MODULE_TEST_VALUE"] == nil, "Sanbox is broken! MODULE_TEST_VALUE is public!")
        assert(self.m_Loader.m_SandboxENV["MODULE_TEST_VALUE"] == 0x0, "Something went wrong, dunno what.")
    else
        delete(self)
        error(err)
    end
end

function Module:destructor()
    if self.m_Loader then
        delete(self.m_Loader)
    end
    ModuleManager:getSingleton():removeRef(self)
end

function Module:getName()
    return self.m_Name
end

function Module:getPath()
    return self.m_Path
end

function Module:parseMeta()
    local xml = xmlLoadFile(("%s/meta.xml"):format(self:getPath()))
	local server = {}
    local client = {} -- Currently not WIP!
	for k, v in pairs(xmlNodeGetChildren(xml)) do
		if xmlNodeGetName(v) == "script" then
            local type = xmlNodeGetAttribute(v, "type")
            local src = xmlNodeGetAttribute(v, "src")
            if type == "server" then
                server[#server+1] = src
            elseif type == "client" then
                client[#client+1] = src
            elseif type == "shared" then
                server[#server+1] = src
                client[#client+1] = src
            end
		end
	end
    xmlUnloadFile(xml)
    return server, client
end