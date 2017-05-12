local BaseClass = require "BaseClass"
local ClassB = class(BaseClass)

function ClassB:init()
    print("ClassB init")
    self:bindEvent()
end

function ClassB:bindEvent()
    self:bind("ClassA.hello", function (...)
        print("ClassB")
        for k,v in pairs({...}) do
            print(k, v)
        end
    end, 10)
end

function ClassB:fire()
    self:call("ClassA.hello", "hello", "nice to meet you")
end

function ClassB:dispose()
    print("ClassB dispose")
end

return ClassB
