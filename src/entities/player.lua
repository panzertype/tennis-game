---@class (exact) Player
---@field x number
---@field y number
---@field width number
---@field height number
Player = {}

---@param o Player
function Player:new(o)
    o = o or {}
    setmetatable(o, { __index = self })
    return o
end

function Player:update()
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)

    local shader = love.graphics.newShader(BLEND_COLOR_SHADER)
    love.graphics.setShader(shader)
    shader:send("blendColor", {1.0, 0.0, 0.0})
    love.graphics.draw(AS_GRAPHICS['tennisist'], self.x, self.y, 0, 2)
    love.graphics.setShader()
end

