---@class (exact) Opponent: Entity
---@field x number
---@field y number
---@field width number
---@field height number
---@field sprite DrawableSprite
Opponent = {}

---@param o Opponent
function Opponent:new(o)
	o = o or {}
	setmetatable(o, { __index = self })
	return o
end

---@param dt number
---@param ball Ball
function Opponent:update(dt, ball)
	local speed = 100
	local half_height = self.height / 2

	if ball.y > self.y + half_height then
		self.y = self.y + speed * dt
	elseif ball.y < self.y + half_height then
		self.y = self.y - speed * dt
	end
end

function Opponent:draw()
	-- love.graphics.rectangle("line", self.x, self.y, self.height, self.width)

	self.sprite.x = self.x + self.width
	self.sprite.y = self.y
	self.sprite:draw()
end
