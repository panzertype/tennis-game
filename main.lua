require('src.dependencies')

local game = GameState:new()

local WINDOW_WIDTH = 640
local WINDOW_HEIGHT = 360
local framebuffer = love.graphics.newCanvas(WINDOW_WIDTH, WINDOW_HEIGHT)
framebuffer:setFilter('nearest', 'nearest')
local render_scale = 0
local render_translate_x = 0
local render_translate_y = 0

function love.load()
	math.randomseed(os.time())
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = true })
	love.window.setTitle('Tennis')
	love.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
end

function love.update(dt)
	game:update(dt)
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
		game:draw()
		love.graphics.translate(render_translate_x, render_translate_y)
		love.graphics.scale(render_scale)
	love.graphics.setCanvas()

	love.graphics.setColor(1, 1, 1);
	love.graphics.draw(framebuffer)
end

