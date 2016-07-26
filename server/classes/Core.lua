Core = inherit(Object)

function Core:constructor()
    -- Small hack to get the global core immediately
	core = self

    -- Debugging
    if DEBUG then
        Debugging:new()
    end


    -- Instantiate classes (Create objects) 
end