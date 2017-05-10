local initLuaLib = function()
	_ENV.class = require "class"
end

local initInstanceModule = function ()
    local instanceList = {
        EventSet = require "Event.EventSet",
    }

    for k,v in pairs(instanceList) do
        _ENV[k] = v.new()
    end
end

initLuaLib()
initInstanceModule()

local a = require "ClassA".new()
local b = require "ClassB".new()

b:fire() -- fire Event
a:destroy() -- A destroy

b:fire() -- fire Event --> not respose
b:destroy() -- B destroy
