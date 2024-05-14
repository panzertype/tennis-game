require('src.dependencies')

math.randomseed(os.time())

local game = GameState:new()

local WINDOW_WIDTH = 640
local WINDOW_HEIGHT = 360
local framebuffer = love.graphics.newCanvas(RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)
local render_scale = 0
local render_translate_x = 0
local render_translate_y = 0

local scanlines_shader = love.graphics.newShader[[
extern number width;
extern number phase;
extern number thickness;
extern number opacity;
extern vec3 color;
vec4 effect(vec4 c, Image tex, vec2 tc, vec2 _) {
	number v = .5*(sin(tc.y * 3.14159 / width * love_ScreenSize.y + phase) + 1.);
	c = Texel(tex,tc);
	//c.rgb = mix(color, c.rgb, mix(1, pow(v, thickness), opacity));
	c.rgb -= (color - c.rgb) * (pow(v,thickness) - 1.0) * opacity;
	return c;
}]]

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, { resizable = true })
	love.window.setTitle('Tennis')
	love.graphics.setBackgroundColor(0, 0, 0)
	framebuffer:setFilter('nearest', 'nearest')
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
		love.graphics.setShader()
		love.graphics.setColor(0.2, 0.2, 0.2)
		love.graphics.rectangle("fill", 0, 0, RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)
			game:draw()
		love.graphics.translate(render_translate_x, render_translate_y)
		love.graphics.scale(render_scale)
		love.graphics.setShader(scanlines_shader)
		scanlines_shader:send("width", 2)
		scanlines_shader:send("phase", 0)
		scanlines_shader:send("thickness", 1)
		scanlines_shader:send("opacity", 0.5)
		scanlines_shader:send("color", { 0, 0, 0 })
	love.graphics.setCanvas()

	love.graphics.setColor(1, 1, 1);
	-- When using the default shader anything drawn with this function will be tinted according to the currently selected color. Set it to pure white to preserve the object's original colors. 
	love.graphics.draw(framebuffer)
end

