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

local player_sprite = love.graphics.newImage("assets/player.png")

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.draw(player_sprite, self.x, self.y, 0, 2)
end

