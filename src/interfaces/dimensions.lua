---@class Dimensions
---@field x number
---@field y number
Dimensions = {}

function Dimensions:new()
    local instance = {}
	setmetatable(instance, { __index = self })
    return instance
end

function Dimensions:getWidth()
    assert(false, "Dimensions getWidth method not implemented")
    return 0
end

function Dimensions:getHeight()
    assert(false, "Dimensions getHeight method not implemented")
    return 0
end