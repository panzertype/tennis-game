---@class Button
---@field hovered boolean
---@field on_press function
---@field text string
---@field x number
---@field y number
Button = {}

local DEFAULT_FONT_SIZE = 14
local PADDING = 8
local font = love.graphics.newFont(DEFAULT_FONT_SIZE)

function Button:new(o)
    o = o or {}
    self.on_press = function ()	end
    self.hovered = false
    setmetatable(o, { __index = self })
    return o
end

function Button:draw()
    local text_width = font:getWidth(self.text)
    local text_height = font:getHeight()

    if self.hovered then
    	love.graphics.setColor(1, 1, 0)
    else
	love.graphics.setColor(1, 1, 1)
    end
    love.graphics.rectangle("line", self.x, self.y, text_width + PADDING * 2, text_height + PADDING * 2)

    if self.hovered then
    	love.graphics.setColor(1, 1, 0)
    else
	love.graphics.setColor(1, 1, 1)
    end
    love.graphics.setFont(font)
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
    return font:getHeight() + PADDING * 2
end

function Button:getWidth()
    return font:getWidth(self.text) + PADDING * 2
end

