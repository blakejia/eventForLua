local EventSet = class()

function EventSet:init()
    print("event set is init!")
    self.eventSet = {}
end

function EventSet:registerEvent(event)
    local name = event:getName()
    if self.eventSet[name] == nil then
        self.eventSet[name] = {}
    end

    self.eventSet[name][event] = {
        event = event,
    }
end

function EventSet:unregisterEvent(event)
    local name = event:getName()
    if self.eventSet[name] == nil then
        print(string.format("this event name is unregister : %s", name))
        return
    end

    if self.eventSet[name][event] == nil then
        print(string.format("this event is unregister : %s", name))
    end

    self.eventSet[name][event] = nil
end

function EventSet:call(name, ...)
    if self.eventSet[name] == nil then
        print(string.format("this event name is unregister : %s", name))
        return
    end

    for _, value in pairs(self.eventSet[name]) do
        value.event:call(...)
    end
end

function EventSet:dispose()
    for name, set in pairs(self.eventSet) do
        for _, event in pairs(set) do
            self:unregisterEvent(event)
        end
    end
end

return EventSet
