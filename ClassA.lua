local BaseClass = require "BaseClass"
local ClassA = class(BaseClass)

function ClassA:init()
    print("ClassA init")
    self:bindEvent()
end

function ClassA:bindEvent()
    self:bind("ClassA.hello", function (...)
        print("ClassA")
        for k,v in pairs({...}) do
            print(k, v)
        end
    end)
end

function ClassA:dispose()
    print("ClassA dispose")
end

return ClassA
