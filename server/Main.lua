Main = {}

function Main.resourceStart()
	-- Instantiate Core
    if type(createFilesystemInterface) == "function" then
	    core = Core:new()
    else
        outputDebugString("MTA:Eir FileSystem Module is not present! See: https://wiki.multitheftauto.com/wiki/Modules/FileSystem", 1)
        stopResource(getThisResource())
    end
end
addEventHandler("onResourceStart", resourceRoot, Main.resourceStart, true, "high+99999")

function Main.resourceStop()
    if core then
		delete(core)
    end
end
addEventHandler("onResourceStop", resourceRoot, Main.resourceStop, true, "low-99999")