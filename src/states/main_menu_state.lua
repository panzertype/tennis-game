---@class (exact) MainMenuState
---@field buttons Button[]
MainMenuState = {}

local START_GAME_BUTTON = Button:new({
    text = "Start",
    x = RENDER_TARGET_WIDTH / 2,
    y = RENDER_TARGET_HEIGHT / 2,
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

