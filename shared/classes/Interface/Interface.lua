-- NOTE: Interfaces have access to the "public code", use with attention!
-- Singleton interfaces use the same instance in all modules!
-- Example: Class = inherit(Singleton) -> Core: Class:new() : table:0x0234 -> Module 1: Class:getSingleton() : table:0x0234
--                                                                         -> Module 2: Class:getSingleton() : table:0x0234
--                                                                         -> Module n: Class:getSingleton() : table:0x0234

Interface = inherit(Object)
Interface.constructor = pure_virtual
Interface.destructor  = pure_virtual
PUBLIC_INTERFACES = {
    Object    = Object;
    Singleton = Singleton;
    Async     = Async;
}

function Interface.onInherit(class)
    setTimer(function ()
        outputDebug("added new public interface class "..tostring(class))
        PUBLIC_INTERFACES[class.PUBLIC_NAME] = class
    end, 50, 1)
end