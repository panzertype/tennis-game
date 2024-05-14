Player = { x = 0, y = 0 }

function Player:new(o)
	o = o or {}
	self.__index = self
	setmetatable(o, self)
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
    if love.keyboard.isDown("left") then
        self.x = self.x - speed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x + speed * dt
    end
end

function Player:draw()
	love.graphics.circle("fill", self.x, self.y, 10)
end

