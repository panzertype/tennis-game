---@class (exact) CustomizeTennisistsState: Entity
---@field private colors number[][]
---@field private state Entity
---@field private player_color number[]
---@field private opponent_color number[]
CustomizeTennisistsState = {}

function CustomizeTennisistsState:new(o)
    o = o or {}
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
		on_pick = function(player_color)
			self.player_color = player_color
			self.state = ColorPickerState:new({
				colors = self.colors,
				title = UI_SELECT_OPPONENT_COLOR_TEXT,
				on_pick = function(opponent_color)
					self.opponent_color = opponent_color
					GAME_STATE:pop()
					GAME_STATE:push(PlayingState:new())
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
