Core = inherit(Object)

function Core:constructor()
    -- Small hack to get the global core immediately
	core = self

    -- Debugging
    if DEBUG then
        Debugging:new()
    end

    -- MTA:Eir Filesystem
    self.ms_FileSystem = createFilesystemInterface()
    self.m_ModuleLocTranslator = self:createFSTranslator(BASE_MODULE_LOC_ABS)

    -- Instantiate classes (Create objects)
    ModuleManager:new()

    setTimer(function ()
        ModuleManager:getSingleton():init()
    end, 1000, 1) -- Cause Interface.onInherit is slow!
end

function Core:destructor()
    delete(ModuleManager:getSingleton())
end

function Core:createFSTranslator(...)
    return self.ms_FileSystem.createTranslator(...)
end

function Core:getModuleTranslator()
    return self.m_ModuleLocTranslator
end