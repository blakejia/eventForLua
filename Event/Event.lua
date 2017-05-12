local Event = class()

function Event:init(obj, eventName, callback, priority)
    assert(eventName ~= nil and callback ~= nil and obj ~= nil, "event init is error")

    self.obj = obj
    self.eventName = eventName
    self.callback = callback
    self.priority = priority or 0

    EventSet:registerEvent(self)
end

function Event:getPriority()
    return self.priority
end

function Event:getName()
    return self.eventName
end

function Event:call(...)
    self.callback(...)
end

function Event:dispose()
    EventSet:unregisterEvent(self)
end

return Event
