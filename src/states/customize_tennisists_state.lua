---@class (exact) CustomizeTennisistsState: Entity
---@field private colors RGBA[]
---@field private state Entity
CustomizeTennisistsState = {}

function CustomizeTennisistsState:new(o)
    o = o or {}
	assert(o.on_customize_end)
    self.colors = {
        AS_COLORS['blue'],
        AS_COLORS['red'],
        AS_COLORS['green'],
        AS_COLORS['light_green'],
        AS_COLORS['yellow']
    }
	self.state = ColorPickerState:new({
		colors = self.colors,
		title = UI_SELECT_PLAYER_COLOR_TEXT,
		on_pick = function(player_color, color_index)
			GAME_CONFIG['player_color'] = player_color
			table.remove(self.colors, color_index)
			self.state = ColorPickerState:new({
				colors = self.colors,
				title = UI_SELECT_OPPONENT_COLOR_TEXT,
				on_pick = function(opponent_color)
					GAME_CONFIG['opponent_color'] = opponent_color
					SAVE_CONFIG()
					GAME_STATE:pop()
					o.on_customize_end()
				end
			})
		end
	})
    setmetatable(o, { __index = self })
    return o
end

function CustomizeTennisistsState:update()
	self.state:update()
end

function CustomizeTennisistsState:draw()
	self.state:draw()
end
