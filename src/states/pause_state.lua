---@class (exact) PauseState: Entity
PauseState = {}

function PauseState:new(o)
	o = o or {}
	setmetatable(o, { __index = self })
	return o
end

local FONT = AS_FONTS["large"]
local FONT_COLOR = AS_COLORS["white"]
local PAUSE_TEXT = UI_PAUSE_OVERLAY_TEXT
local PAUSE_TEXT_WIDTH = FONT:getWidth(PAUSE_TEXT)
local PAUSE_TEXT_PADDING = FONT:getHeight()

function PauseState:draw()
	love.graphics.setColor(Rgba(AS_COLORS["black"], 0.6))
	love.graphics.rectangle("fill", 0, 0, RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)

	love.graphics.setColor(FONT_COLOR)
	love.graphics.setFont(FONT)
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
