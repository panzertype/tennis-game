---@class (exact) MainMenuState
---@field buttons Button[]
MainMenuState = {}

local FONT = AS_FONTS['small']

local START_GAME_BUTTON = Button:new({
    text = UI_START_BUTTON_TEXT,
    x = RENDER_TARGET_WIDTH / 2 - FONT:getWidth(UI_START_BUTTON_TEXT) / 2 - UI_BUTTON_DEFAULT_PADDING,
    y = RENDER_TARGET_HEIGHT / 2 - FONT:getHeight(),
    font = FONT,
    on_press = function ()
	GameState:pop()
	GameState:push(PlayingState:new())
    end
})

function MainMenuState:new(o)
    o = o or {}
    self.buttons = { START_GAME_BUTTON }
    setmetatable(o, { __index = self })
    return o
end

function MainMenuState:draw()
    for i = 1, #self.buttons do
	self.buttons[i]:draw()
    end
end

function MainMenuState:update()
    for i = 1, #self.buttons do
	self.buttons[i]:update()
    end
end

