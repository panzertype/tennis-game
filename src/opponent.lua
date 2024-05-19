
---@class (exact) Opponent
---@field x number
---@field y number
---@field width number
---@field height number
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

    if ball.y > self.y then
	self.y = self.y + speed * dt
    elseif ball.y < self.y then
	self.y = self.y - speed * dt
    end
end

local opponent_sprite = love.graphics.newImage("assets/opponent.png")

function Opponent:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.draw(opponent_sprite, self.x, self.y, 0, 2)
end

