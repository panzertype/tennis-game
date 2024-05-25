
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
    local half_height = self.height / 2

    if ball.y > self.y + half_height then
	self.y = self.y + speed * dt
    elseif ball.y < self.y + half_height then
	self.y = self.y - speed * dt
    end
end

function Opponent:draw()
    love.graphics.setColor(WHITE)
    -- love.graphics.rectangle("line", self.x, self.y, self.height, self.width)

    local shader = love.graphics.newShader(BLEND_COLOR_SHADER)
    love.graphics.setShader(shader)
    shader:send("blendColor", AS_COLORS['blue'])
    love.graphics.draw(AS_GRAPHICS['tennisist'], self.x + self.width, self.y, 0, -2, 2)
    love.graphics.setShader()
end

