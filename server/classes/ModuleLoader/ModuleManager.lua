ModuleManager = inherit(Singleton)

function ModuleManager:constructor()
    self.m_Modules = {}
end

function ModuleManager:destructor()
    for id, module in pairs(self.m_Modules) do
        delete(module)
    end
end

function ModuleManager:addRef(module)
    local id = #self.m_Modules + 1
    self.m_Modules[id] = module
    return id
end

function ModuleManager:removeRef(module)
    local id = table.find(self.m_Modules, module)
    if id then
        self.m_Modules[id] = nil
    end
end

function ModuleManager:getFromId(id)
    return self.m_Modules[id]
end

function ModuleManager:getIdFromInstance(module)
    local id = table.find(self.m_Modules, module)
    if id then
        return id
    end
    return false
end

function ModuleManager:init()
    outputDebug("Trying to load modules.")
    local modules, invalid = ModuleManager.searchModules()
    outputDebug(("Found %d module(s)! %d are invalid."):format(#modules + #invalid, #invalid))
    if #invalid >= 1 then
        for i, path in pairs(invalid) do
            outputDebug(("Invalid module: %s"):format(transformModulePath(path)))
        end
    end
    if #modules >= 1 then
        for i, path in ipairs(modules) do
            outputDebug(("Loading module: %s"):format(transformModulePath(path)))
            Module:new(path)
        end
    end
end

function ModuleManager.searchModules()
    local modules = {}
    local invalid = {}
    local translator = core:getModuleTranslator()
    for _, path in pairs(translator.scanDir("/", "*", false)) do
        if isDirectory(path) then
            local path = translator.relPath(path)
            if isModuleValid(path) then
                modules[#modules+1] = path
            else
                invalid[#invalid+1] = path
            end
        end
    end
    return modules, invalid
end