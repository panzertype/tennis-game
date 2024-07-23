---@class Range: Entity, Dimensions
---@field private step number
---@field private step_index number
---@field private min number
---@field private max number
---@field private width number
---@field on_change fun(value: number)
---@field value number
---@field x number
---@field y number
Range = {}

function Range:new(o)
	assert(o.width)
	assert(o.min)
	assert(o.max)
	assert(o.step)
	assert(o.value)
	assert(o.value >= o.min and o.value <= o.max)
	assert(o.value % o.step == 0)
	o = o or {}
	self.step_index = 0
	self.on_press = function() end
	setmetatable(o, { __index = self })
	return o
end

function Range:update()
	local mouse_release_x, mouse_release_y = love.mouse.release_position.x, love.mouse.release_position.y
	local is_clicked = Collides(self.x, self.y, self:get_width(), self:get_height(), mouse_release_x, mouse_release_y, 1,
		1)

	local mouse_x, mouse_y = love.mouse.position.x, love.mouse.position.y
	local is_cursor_over_range = Collides(self.x, self.y, self:get_width(), self:get_height(), mouse_x, mouse_y, 1, 1)
	self.hovered = is_cursor_over_range

	if is_clicked then
		local one_step_width = self:get_one_step_width()
		local press_relative_position = math.abs(mouse_x - self.x)

		self.step_index = math.floor((press_relative_position / one_step_width) + 0.5)
		self.value = self.min + (self.step_index * self.step)

		print(self.value)
		self.on_change(self.value)
	end
end

function Range:get_height()
	return 10;
end

function Range:get_width()
	return self.width;
end

function Range:get_cursor_height()
	return self:get_height() * 3
end

function Range:get_cursor_width()
	return self:get_height()
end

function Range:get_one_step_width()
	local num_steps = (self.max - self.min) / self.step
	return self.width / num_steps
end

function Range:draw()
	love.graphics.setColor(self.hovered and AS_COLORS["yellow"] or AS_COLORS["light_gray"])
	love.graphics.rectangle("line", self.x, self.y, self.width, self:get_height())
	love.graphics.rectangle(
		"fill",
		self.x + ((self.value - self.min) / self.step * self:get_one_step_width()) - (self:get_cursor_width() / 2) - 1,
		self.y - self:get_height(),
		self:get_cursor_width() + 2,
		self:get_cursor_height()
	)
end
