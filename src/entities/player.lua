---@class (exact) Player
---@field x number
---@field y number
---@field width number
---@field height number
---@field sprite DrawableSprite
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
    self.sprite.x = self.x
    self.sprite.y = self.y
    self.sprite:draw()
end

