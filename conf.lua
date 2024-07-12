require('src.constants')

function love.conf(t)
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT
    t.window.title = WINDOW_TITLE
    t.window.resizable = true
end