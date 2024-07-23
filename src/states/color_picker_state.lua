---@class (exact) ColorPickerState: Entity
---@field private colors RGBA[]
---@field private title string
---@field private ui Stack
---@field private current_color_index number
---@field private tennisist_sprite DrawableSprite
---@field private pick_button Button
ColorPickerState = {}

function ColorPickerState:new(o)
	o = o or {}
	assert(#o.colors > 1)
	self.current_color_index = 1
	self.tennisist_sprite =
		DrawableSprite:new({
			graphics = AS_GRAPHICS["tennisist"],
			rgba = o.colors[self.current_color_index],
			scale = 4
		})
	local color_picker_controls_stack = {
		Button:new({
			text = UI_PREV_BUTTON_TEXT,
			font = AS_FONTS["small"],
			on_press = function()
				o:previous_color()
			end,
		}),
		self.tennisist_sprite,
		Button:new({
			text = UI_NEXT_BUTTON_TEXT,
			font = AS_FONTS["small"],
			on_press = function()
				o:next_color()
			end,
		}),
	}
	self.ui = Stack:new({
		width = RENDER_TARGET_WIDTH,
		height = RENDER_TARGET_HEIGHT,
		gap = RENDER_TARGET_WIDTH / 4,
		children = color_picker_controls_stack,
		direction = 'horizontal'
	})
	local pick_button =
		Button:new({
			text = UI_CONFIRM_BUTTON_TEXT,
			font = AS_FONTS["small"],
		})
	self.pick_button =
		Button:new({
			text = pick_button.text,
			font = pick_button.font,
			on_press = function()
				o.on_pick(o.colors[o.current_color_index], o.current_color_index)
			end,
			x = (RENDER_TARGET_WIDTH / 2) - (pick_button:get_width() / 2),
			y = RENDER_TARGET_HEIGHT - pick_button:get_height() - UI_BUTTON_DEFAULT_PADDING
		})
	setmetatable(o, { __index = self })
	return o
end

function ColorPickerState:previous_color()
	self.current_color_index = self.current_color_index - 1
	if self.current_color_index == 0 then
		self.current_color_index = #self.colors
	end
	self.tennisist_sprite.rgba = self.colors[self.current_color_index]
end

function ColorPickerState:next_color()
	self.current_color_index = self.current_color_index + 1
	if self.current_color_index > #self.colors then
		self.current_color_index = 1
	end
	self.tennisist_sprite.rgba = self.colors[self.current_color_index]
end

function ColorPickerState:draw()
	self.ui:draw()

	love.graphics.setColor(AS_COLORS['white'])
	love.graphics.setFont(AS_FONTS['medium'])
	love.graphics.print(
		self.title,
		RENDER_TARGET_WIDTH / 2 - love.graphics.getFont():getWidth(self.title) / 2,
		love.graphics.getFont():getHeight() / 2
	)

	self.pick_button:draw()
end

function ColorPickerState:update()
	self.ui:update()
	self.pick_button:update()
end
