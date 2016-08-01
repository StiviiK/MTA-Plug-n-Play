Interface = inherit(Object)
Interface.constructor = pure_virtual
Interface.destructor  = pure_virtual
PUBLIC_INTERFACES = {
    Object    = Object;
    Singleton = Singleton;
}

function Interface.onInherit(class)
    setTimer(function ()
        outputDebug("added new public interface class "..tostring(class))
        PUBLIC_INTERFACES[class.PUBLIC_NAME] = class
    end, 50, 1)
end

MyClass = inherit(Interface)
MyClass.PUBLIC_NAME = "adg"
function MyClass:constructor(n)
    self.m_N = n
end

function MyClass:getN()
    return self.m_N
end