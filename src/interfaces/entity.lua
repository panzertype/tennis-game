---@class Entity
Entity = {}

function Entity:new()
    local instance = {}
	setmetatable(instance, { __index = self })
    return instance
end

function Entity:update()
    assert(false, "Entity update method not implemented")
end

function Entity:draw()
    assert(false, "Entity draw method not implemented")
end