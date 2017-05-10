local BaseClass = require "BaseClass"
local ClassB = class(BaseClass)

function ClassB:init()
    print("ClassB init")
end

function ClassB:fire()
    self:call("ClassA.hello", "hello", "nice to meet you")
end

function ClassB:dispose()
    print("ClassB dispose")
end

return ClassB
