local Event = require "Event.Event"
local BaseClass = class()

function BaseClass:init()
    self.eventList = {}
end

function BaseClass:bind(key, call)
    if self.eventList[key] ~= nil then
        print('Dumplicate event name! : ' .. key)
        return
    end

    local event = Event.new(self, key, call)
    self.eventList[key] = event
end

function BaseClass:unbind(key)
    local event = self.eventList[key]
    if event == nil then
        print('event name is nil! : ' .. key)
        return
    end

    event:destroy()
    self.eventList[key] = nil
end

function BaseClass:call(key, ...)
    EventSet:call(key, ...)
end

function BaseClass:clearEvent()
    for k,v in pairs(self.eventList) do
        self:unbind(k)
    end
    self.eventList = {}
end

function BaseClass:dispose()
    self:clearEvent()
end

return BaseClass
