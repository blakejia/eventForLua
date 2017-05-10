local Event = class()

function Event:init(obj, eventName, callback)
    self.obj = obj
    self.eventName = eventName
    self.callback = callback

    EventSet:registerEvent(self)
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
