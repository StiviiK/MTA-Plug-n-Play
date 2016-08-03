Sandbox = inherit({}) -- No Inherit needed
BASE_ENV = {}

-- From https://github.com/APItools/sandbox.lua/blob/master/sandbox.lua#L51-L82
([[
_VERSION assert error ipairs next pairs
pcall print select tonumber tostring type unpack xpcall
coroutine.create coroutine.resume coroutine.running coroutine.status
coroutine.wrap   coroutine.yield
math.abs   math.acos math.asin  math.atan math.atan2 math.ceil
math.cos   math.cosh math.deg   math.exp  math.fmod  math.floor
math.frexp math.huge math.ldexp math.log  math.log10 math.max
math.min   math.modf math.pi    math.pow  math.rad   math.random
math.sin   math.sinh math.sqrt  math.tan  math.tanh
string.byte string.char  string.find  string.format string.gmatch
string.gsub string.len   string.lower string.match  string.reverse
string.sub  string.upper setfenv
table.insert table.maxn table.remove table.sort

enew new delete super inherit _inheritIndex __removeElementIndex
instanceof pure_virtual bind oop
]]):gsub('%S+', function(id)
  local module, method = id:match('([^%.]+)%.([^%.]+)')
  if module then
    BASE_ENV[module]         = BASE_ENV[module] or {}
    BASE_ENV[module][method] = _G[module][method]
  else
    BASE_ENV[id] = _G[id]
  end
end)

function Sandbox.init(env)
    return merge(merge(env or {}, PUBLIC_INTERFACES), BASE_ENV)
end

function Sandbox.create(sandbox, func)
    if not sandbox or not func then return end
    setfenv(func, sandbox)

    return function(...)
        local status, result = pcall(func, ...)
        if status == false then
            return false, result
        end
        return result
    end
end

function Sandbox.test()
    local sandbox = Sandbox.init()
    Sandbox.create(sandbox, function ()
       print(adg:new())
    end)()
end