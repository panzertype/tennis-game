---@class (exact) Ball
---@field x number
---@field y number
---@field dx number
---@field dy number
---@field width number
---@field height number
Ball = {}

---@param o Ball
function Ball:new(o)
    o = o or {}
    setmetatable(o, { __index = self })
    return o
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw()
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

