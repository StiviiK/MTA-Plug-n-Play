ModuleLoader = inherit(Object)

function ModuleLoader:constructor(module)
    self.m_Module = module
    self.m_Code = {}
    self.m_SandboxENV = Sandbox.init()
    self.m_SandboxLoader = Sandbox.create(self.m_SandboxENV, function ()
        for i, codeBlock in ipairs(self.m_Code) do
            setfenv(codeBlock, self.m_SandboxENV) -- we have to re-set the environment cause we have a new code block
            assert(pcall(codeBlock))
        end 

        if Main and Main.onStart then
            Main.onStart()
        end

        return true
    end)
end

function ModuleLoader:destructor()
    if self.m_SandboxENV.Main and self.m_SandboxENV.Main.onStop then
        self.m_SandboxENV.Main.onStop()
    end
    for i, v in pairs(self.m_SandboxENV) do
        if isTimer(v) or isElement(v) then
            v:destroy()
        end
    end
end

function ModuleLoader:addFiles(files)
    for i, path in ipairs(files) do
        local path = ("%s%s"):format(self.m_Module:getPath(), path)
        if fileExists(path) then
            outputDebug("Adding File: "..path)
            local file = fileOpen(path)
            local func, err = loadstring(file:read(file:getSize()))
            file:close()

            if err then
                return false, err
            end
            self.m_Code[#self.m_Code+1] = func
        else
            outputDebug("File not Found: "..path)    
        end
    end

    return true
end