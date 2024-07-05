---@class (exact) Tennisist: Entity
---@field x number
---@field y number
---@field width number
---@field height number
---@field sprite DrawableSprite
Tennisist = {}

---@param o Tennisist
function Tennisist:new(o)
	o = o or {}
	setmetatable(o, { __index = self })
	return o
end

function Tennisist:update()
end

function Tennisist:draw()
	self.sprite.x = self.x
	self.sprite.y = self.y
	self.sprite:draw()
end
