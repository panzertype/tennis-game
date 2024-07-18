---@class (exact) PauseState: Entity
---@field ui Stack
PauseState = {}

function PauseState:new(o)
	o = o or {}

	self.ui = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = 50,
		children = {
			Text:new({
				text = UI_PAUSE_OVERLAY_TEXT,
				font = AS_FONTS['large'],
				color = AS_COLORS['white']
			}),
			Button:new({
				text = UI_EXIT_BUTTON_TEXT,
				font = AS_FONTS['small'],
				on_press = function()
					GAME_STATE:pop()
					GAME_STATE:pop()
					GAME_STATE:push(MainMenuState:new())
				end,
			})
		},
		direction = 'vertical'
	})

	setmetatable(o, { __index = self })
	return o
end

function PauseState:draw()
	DrawBackdrop()
	self.ui:draw()
end

function PauseState:update()
	self.ui:update()
	if love.keyboard.wasPressed("escape") then
		GAME_STATE:pop()
	end
end
