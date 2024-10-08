---@class Text: Entity, Dimensions
---@field text string
---@field font love.Font
---@field x number
---@field y number
---@field color RGBA
Text = {}

function Text:new(o)
	o = o or {}
	self.x = 0
	self.y = 0
	setmetatable(o, { __index = self })
	return o
end

function Text:get_width()
	return self.font:getWidth(self.text)
end

function Text:get_height()
	return self.font:getHeight()
end

function Text:update()
end

function Text:draw()
	love.graphics.setColor(self.color)
	love.graphics.setFont(self.font)
	love.graphics.print(
		self.text,
		self.x,
		self.y
	)
end
