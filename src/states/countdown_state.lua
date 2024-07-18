---@class (exact) CountdownState: Entity
---@field private ui Stack
---@field private count_start number 
---@field private count_from number 
---@field private count_till number 
---@field private count_text number 
CountdownState = {}

function CountdownState:new(o)
	o = o or {}
	self.count_start = love.timer.getTime()
	self.count_from = o.count_from
	self.count_till = o.count_till
	self.count_text = 0
	assert(self.count_from > self.count_till)
	self.ui = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = 0,
		direction = 'horizontal',
		children = {
			Text:new({
				text = tostring(self.count_text),
				font = AS_FONTS['large'],
				color = AS_COLORS['white']
			}
		)}
	})
	setmetatable(o, { __index = self })
	return o
end

function CountdownState:draw()
	DrawBackdrop()
	self.ui:draw()
end

function CountdownState:update()
	local current_time = love.timer.getTime()
	local elapsed_time = current_time - self.count_start
	local remaining_time = self.count_from - math.floor(elapsed_time)
	self.count_text = math.max(self.count_till, remaining_time)

	if elapsed_time > (self.count_from - self.count_till) then
		GAME_STATE:pop()
	end

	self.ui.children[1].text = tostring(self.count_text)
	self.ui:update()
end
