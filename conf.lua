require('src.constants')

function love.conf(t)
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.title = WINDOW_TITLE
    t.window.resizable = true

    t.modules.data = false
    t.modules.math = false
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.system = false
    t.modules.thread = false
    t.modules.touch = false
    t.modules.video = false
end