--File Name		: class.lua
--Author		: Rick

--[[
1.定义基类
A = class()

function A:init(a, b) -- 构造函数
	self.a = a
	self.b = b
	print("A:init", a, b)
end

function A:Test()
	print("A:Test")
	for k,v in pairs(self) do
		print(k,v)
	end
end

2.继承
B = class(A)

function B:init(a, b, c, d) -- 先调用父类构造
	self.c = c
	self.d = d
	print("B:init", c, d)
end

function B:Test() -- 重载
	print("B:Test1")
end

a = A(100, 200)
b = B(1, 2, 3, 4)

a:Test()
b:Test()
--b:Test1()

--]]

local function class(base)
	assert(base == nil or type(base) == "table")

	local cls = {}
	local mt = {}
	local obj_mt = {
        __index = cls,
        __newindex = function(self, key, value)
--            if cls[key] ~= nil then
--                Debug.LogError(debug.traceback("[ERROR] '" .. key .. "' is keyword", 2))
--                return
--            end

            rawset(self, key, value)
        end,
    }

	function cls.attach(obj)
		return setmetatable(obj, obj_mt)
	end

	-- function cls.new(_, ...)
	-- 	return cls.attach({}):__init(...)
	-- end

	local checkUI = function(param)
		if type(param) ~= "table" then
			return false
		end

		local isUI = param.isUI
        param.isUI = nil
		return isUI or false
	end

	function cls.new(param, ...)
		if checkUI(param) then
			return cls.attach(param):__init(...)
		end

		return cls.attach({}):__init(param, ...)
	end

	function cls.inherit(base)
		assert(type(base) == "table")

		cls.super = base
		mt.__index = base
	end

	function cls.__init(obj, ...)
		local super = cls.super
		if super then
			super.__init(obj, ...)
		end

		local init = rawget(cls, "init")
		if init then
			init(obj, ...)
		end

		return obj
	end

    function cls.get(self, key)
        if key == nil then
            return nil
        end

        return self[key]
    end

    local doDestroy
    doDestroy = function(curCls, obj, called)
        if called[curCls] then
            return
        end

        called[curCls] = true

        local onDestroy = rawget(curCls, "dispose")
        if onDestroy then
            onDestroy(obj)
        end

        local super = rawget(curCls, "super")
        if super then
            doDestroy(super, obj, called)
        end
    end

    function cls.destroy(self)
        local called = {}
        doDestroy(cls, self, called)
        self._isDestroyed = true
    end

    function cls.isDispose(self)
        return self._isDestroyed or false
    end

    function cls.set(self, key, value)
        if key == nil then
            return
        end

        self[key] = value
    end

	-- mt.__call = cls.new

	if base then
		cls.inherit(base)
	end

	return setmetatable(cls, mt)
end

return class
