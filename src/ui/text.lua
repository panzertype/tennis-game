---@class Text
---@field text string
---@field font love.Font
---@field x number
---@field y number
---@field color number[] 
Text = {}

---@param o Text
function Text:new(o)
	o = o or {}
	setmetatable(o, { __index = self })
	return o
end

function Text:getWidth()
    return self.font:getWidth(self.text)
end

function Text:getHeight()
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