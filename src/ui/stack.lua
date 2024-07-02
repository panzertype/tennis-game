---@class Stack
---@field width number
---@field height number
---@field gap number
---@field children Button[]
---@field direction 'horizontal' | 'vertical'
Stack = {}

---@param o Stack
function Stack:new(o)
	o = o or {}
	self.direction = 'vertical'
	setmetatable(o, { __index = self })
	o:setup()
	return o
end

---@private
function Stack:setup()
	assert(#self.children >= 1)

	local total_height = 0
	local total_width = 0
	for i = 1, #self.children do
		local child_width = self.children[i]:getWidth()
		local child_height = self.children[i]:getHeight()

		if self.direction == 'vertical' then
			total_height = total_height + child_height
			if total_width < child_width then
				total_width = child_width
			end
		else
			total_width = total_width + child_width
			if total_height < child_height then
				total_height = child_height
			end
		end
	end

	if self.direction == 'vertical' then
		total_height = total_height + ((#self.children - 1) * self.gap)
	else
		total_width = total_width + ((#self.children - 1) * self.gap)
	end

	assert(total_height <= self.height)
	assert(total_width <= self.width)

	local y = (self.height / 2) - (total_height / 2)
	local x = (self.width / 2) - (total_width / 2)

	for i = 1, #self.children do
		self.children[i].x = x
		self.children[i].y = y
		local gap = i ~= #self.children and self.gap or 0
		if self.direction == 'vertical' then
			y = y + self.children[i]:getHeight() + gap
		else
			x = x + self.children[i]:getWidth() + gap
		end
	end
end

function Stack:update()
	for i = 1, #self.children do
		self.children[i]:update()
	end
end

function Stack:draw()
	for i = 1, #self.children do
		self.children[i]:draw()
	end
end
