---@class Dimensions
---@field x number
---@field y number
Dimensions = {}

function Dimensions:new()
    local instance = {}
	setmetatable(instance, { __index = self })
    return instance
end

function Dimensions:get_width()
    assert(false, "Dimensions get_width method not implemented")
    return 0
end

function Dimensions:get_height()
    assert(false, "Dimensions get_height method not implemented")
    return 0
end