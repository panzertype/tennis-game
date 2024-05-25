---@class Button
---@field hovered boolean
---@field on_press function
---@field text string
---@field font love.Font
---@field x number
---@field y number
Button = {}

local font = AS_FONTS['small']
local PADDING = UI_BUTTON_DEFAULT_PADDING

function Button:new(o)
    o = o or {}
    self.on_press = function ()	end
    self.hovered = false
    self.font = font
    setmetatable(o, { __index = self })
    return o
end

function Button:draw()
    local text_width = self.font:getWidth(self.text)
    local text_height = self.font:getHeight()

    if self.hovered then
    	love.graphics.setColor(AS_COLORS['yellow'])
    else
	love.graphics.setColor(AS_COLORS['white'])
    end
    love.graphics.rectangle("line", self.x, self.y, text_width + PADDING * 2, text_height + PADDING * 2)

    love.graphics.setFont(self.font)
    love.graphics.print(
	self.text,
	self.x + PADDING,
	self.y + PADDING
    )
end

function Button:update()
    local mouse_x, mouse_y = love.mouse.position.x, love.mouse.position.y
    -- print(mouse_x, mouse_y, self.x, self.y)
    local is_cursor_over_button = Collides(self.x, self.y, self:getWidth(), self:getHeight(), mouse_x, mouse_y, 1, 1)
    self.hovered = is_cursor_over_button

    if is_cursor_over_button and love.mouse.isDown(1) then
	self.on_press()
    end
end

function Button:getHeight()
    return self.font:getHeight() + PADDING * 2
end

function Button:getWidth()
    return self.font:getWidth(self.text) + PADDING * 2
end

