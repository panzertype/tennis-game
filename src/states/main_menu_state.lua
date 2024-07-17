---@class (exact) MainMenuState: Entity
---@field private stack Stack
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
				if GAME_CONFIG['player_color'] and GAME_CONFIG['opponent_color'] then
					GameState:push(PlayingState:new())
				else
					GameState:push(CustomizeTennisistsState:new({
						on_customize_end = function ()
							GameState:push(PlayingState:new())
						end
					}))
				end
			end,
		}),
		Button:new({
			text = UI_CUSTOMIZE_BUTTON_TEXT,
			font = FONT,
			on_press = function()
				GameState:pop()
				GameState:push(CustomizeTennisistsState:new({
					on_customize_end = function()
						GameState:push(MainMenuState:new())
					end
				}))
			end,
		}),
		Button:new({
			text = UI_SETTINGS_BUTTON_TEXT,
			font = FONT,
			on_press = function()
				GameState:pop()
				GameState:push(SettingsState:new())
			end,
		}),
		Button:new({
			text = UI_EXIT_BUTTON_TEXT,
			font = FONT,
			on_press = function()
				love.event.quit(0)
			end,
		}),
	}
	self.stack = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = 10,
		children = buttons,
		direction = 'vertical'
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