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

function Player:update(dt)
    local speed = 100
    if love.keyboard.isDown("up") then
	self.y = self.y - speed * dt
    end
    if love.keyboard.isDown("down") then
	self.y = self.y + speed * dt
    end
 --    if love.keyboard.isDown("left") then
	-- self.x = self.x - speed * dt
 --    end
 --    if love.keyboard.isDown("right") then
	-- self.x = self.x + speed * dt
 --    end
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

