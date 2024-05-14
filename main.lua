require('src.dependencies')

G_WINDOW_WIDTH = 320
G_WINDOW_HEIGHT = 180

local game = GameState:new()

function love.load()
	math.randomseed(os.time())
	love.window.setMode(G_WINDOW_WIDTH, G_WINDOW_HEIGHT)
	love.window.setTitle('Tennis')
	love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end
