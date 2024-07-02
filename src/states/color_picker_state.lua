---@class (exact) ColorPickerState
---@field entities any[] any class with "draw()" and "update()" methods
---@field current_color_index number
---@field tennisist_sprite DrawableSprite
ColorPickerState = {}

local COLORS = {
	AS_COLORS['blue'],
	AS_COLORS['red'],
	AS_COLORS['green'],
	AS_COLORS['light_green'],
	AS_COLORS['yellow']
}

local SELECT_PLAYER_COLOR_TEXT = 'Select player color'

function ColorPickerState:new(o)
	o = o or {}
	self.current_color_index = 1
	self.tennisist_sprite =
		DrawableSprite:new({
			graphics = AS_GRAPHICS["tennisist"],
			rgba = COLORS[self.current_color_index],
			scale = 4
		})
	local color_picker_controls_stack = {
		Button:new({
			text = 'Prev',
			font = AS_FONTS["small"],
			on_press = function()
				o:previous_color()
			end,
		}),
		self.tennisist_sprite,
		Button:new({
			text = 'Next',
			font = AS_FONTS["small"],
			on_press = function()
				o:next_color()
			end,
		}),
	}
	self.entities = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = RENDER_TARGET_WIDTH / 4,
		children = color_picker_controls_stack,
		direction = 'horizontal'
	})
	setmetatable(o, { __index = self })
	return o
end

function ColorPickerState:previous_color()
	self.current_color_index = self.current_color_index - 1
	if self.current_color_index == 0 then
		self.current_color_index = #COLORS
	end
	self.tennisist_sprite.rgba = COLORS[self.current_color_index]
end

function ColorPickerState:next_color()
	self.current_color_index = self.current_color_index + 1
	if self.current_color_index > #COLORS then
		self.current_color_index = 1
	end
	self.tennisist_sprite.rgba = COLORS[self.current_color_index]
end

function ColorPickerState:draw()
	self.entities:draw()

	love.graphics.setColor(AS_COLORS['white'])
	love.graphics.setFont(AS_FONTS['medium'])
	love.graphics.print(
		SELECT_PLAYER_COLOR_TEXT,
		RENDER_TARGET_WIDTH / 2 - love.graphics.getFont():getWidth(SELECT_PLAYER_COLOR_TEXT) / 2,
		love.graphics.getFont():getHeight() / 2
	)
end

function ColorPickerState:update()
	self.entities:update()
end
