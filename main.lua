love.graphics.setDefaultFilter("nearest", "nearest")

require('src.dependencies')

GAME_STATE = GameState:new({ MainMenuState:new() })

local framebuffer = love.graphics.newCanvas(RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)
local render_scale = 0
local render_translate_x = 0
local render_translate_y = 0

function love.load()
    math.randomseed(os.time())
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = true })
    love.window.setTitle(WINDOW_TITLE)
    love.graphics.setBackgroundColor(BLACK)
    framebuffer:setFilter('nearest', 'nearest')
    love.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
    local music = AS_AUDIO['music']
    music:setVolume(0.1)
    music:setLooping(true)
    music:play()
    love.keyboard.keys_pressed = {}
    love.mouse.position = {
        x = 0,
        y = 0
    }
end

function love.update(dt)
    GAME_STATE:update(dt)

    love.keyboard.keys_pressed = {}
    local mouse_x, mouse_y = love.mouse.getPosition()
    love.mouse.position = {
        x = (mouse_x - render_translate_x) / render_scale,
        y = (mouse_y - render_translate_y) / render_scale
    }
end

function love.resize(w, h)
    local scaleX = w / RENDER_TARGET_WIDTH
    local scaleY = h / RENDER_TARGET_HEIGHT

    local scale = math.min(scaleX, scaleY)
    render_scale = scale

    render_translate_x = (w - RENDER_TARGET_WIDTH * scale) / 2
    render_translate_y = (h - RENDER_TARGET_HEIGHT * scale) / 2
end

function love.draw()
    love.graphics.setCanvas(framebuffer)
    love.graphics.clear()
    love.graphics.setShader()
    love.graphics.setColor(AS_COLORS['gray'])
    love.graphics.rectangle("fill", 0, 0, RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)
    GAME_STATE:draw()
    love.graphics.translate(render_translate_x, render_translate_y)
    love.graphics.scale(render_scale)
    love.graphics.setShader(AS_SHADERS['scanlines'])
    love.graphics.setCanvas()

    love.graphics.setColor(WHITE);
    -- When using the default shader anything drawn with this function will be tinted according to the currently selected color. Set it to pure white to preserve the object's original colors.
    love.graphics.draw(framebuffer)
end

function love.keypressed(key)
    love.keyboard.keys_pressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keys_pressed[key]
end
