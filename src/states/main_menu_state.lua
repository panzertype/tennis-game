---@class (exact) MainMenuState
---@field stack Stack
MainMenuState = {}

local FONT = AS_FONTS["small"]

function MainMenuState:new(o)
	o = o or {}
	local buttons = {
		Button:new({
			text = UI_START_BUTTON_TEXT,
			font = FONT,
			on_press = function()
				GameState:pop()
				GameState:push(PlayingState:new())
			end,
		}),
	}
	self.stack = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = 10,
		children = buttons,
	})
	setmetatable(o, { __index = self })
	return o
end

function MainMenuState:draw()
	self.stack:draw()
end

function MainMenuState:update()
	self.stack:update()
end
