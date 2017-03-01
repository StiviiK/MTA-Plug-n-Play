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