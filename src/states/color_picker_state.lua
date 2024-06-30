---@class (exact) ColorPickerState
---@field stack Stack
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
local FONT = AS_FONTS["small"]

function ColorPickerState:new(o)
	o = o or {}
	local buttons = {
		Button:new({
			text = 'Previous',
			font = FONT,
			on_press = function()
				o:previous_color()
			end,
		}),
		Button:new({
			text = 'Next',
			font = FONT,
			on_press = function()
				o:next_color()
			end,
		}),
	}
	self.stack = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = RENDER_TARGET_HEIGHT / 2,
		children = buttons,
	})
	self.tennisist_sprite =
		DrawableSprite:new({
			graphics = AS_GRAPHICS["tennisist"],
			rgba = COLORS[self.current_color_index],
			x = RENDER_TARGET_WIDTH / 2,
			y = RENDER_TARGET_HEIGHT / 2,
			scale = 2
		})
	self.current_color_index = 1
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
	self.stack:draw()
	self.tennisist_sprite:draw()
end

function ColorPickerState:update()
	self.stack:update()
end
