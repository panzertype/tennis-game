---@class (exact) PauseState
PauseState = {}

function PauseState:new(o)
    o = o or {}
    setmetatable(o, { __index = self })
    return o
end


local FONT_SIZE = 24
local font = love.graphics.newFont(FONT_SIZE)
local PAUSE_TEXT = "-- PAUSED --"
local PAUSE_TEXT_WIDTH = font:getWidth(PAUSE_TEXT)
local PAUSE_TEXT_PADDING = FONT_SIZE

function PauseState:draw()
    love.graphics.setColor(0, 0, 0, 0.6);
    love.graphics.rectangle("fill", 0, 0, RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.print(
	PAUSE_TEXT,
	RENDER_TARGET_WIDTH / 2 - PAUSE_TEXT_WIDTH / 2,
	PAUSE_TEXT_PADDING
    )
end

function PauseState:update()
    if love.keyboard.wasPressed("escape") then
	GAME_STATE:pop()
    end
end

