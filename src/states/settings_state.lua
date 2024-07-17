---@class (exact) SettingsState: Entity
---@field private ui Stack
SettingsState = {}

function SettingsState:new(o)
	o = o or {}
	self.ui = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = 15,
		direction = 'vertical',
		children = {
			Text:new({
				text = 'SFX',
				font = AS_FONTS['medium'],
				color = AS_COLORS['white']
			}),
			Range:new({
				width = 100,
				min = 0,
				max = 1,
				step = 0.1,
				value = GAME_CONFIG['sfx_volume'],
				on_change = function(volume)
					GAME_CONFIG['sfx_volume'] = volume
					AS_AUDIO['racket_hit']:setVolume(volume)
					SAVE_CONFIG()
				end
			}),
			Text:new({
				text = 'Music',
				font = AS_FONTS['medium'],
				color = AS_COLORS['white']
			}),
			Range:new({
				width = 100,
				min = 0,
				max = 0.3,
				step = 0.05,
				value = GAME_CONFIG['music_volume'],
				on_change = function(volume)
					GAME_CONFIG['music_volume'] = volume
					AS_AUDIO['music']:setVolume(volume)
					SAVE_CONFIG()
				end
			}),
			Button:new({
				text = UI_EXIT_BUTTON_TEXT,
				font = AS_FONTS['small'],
				on_press = function()
					GameState:pop()
					GameState:push(MainMenuState:new())
				end,
			}),
		},
	})
	setmetatable(o, { __index = self })
	return o
end

function SettingsState:draw()
	self.ui:draw()
end

function SettingsState:update()
	self.ui:update()
end
