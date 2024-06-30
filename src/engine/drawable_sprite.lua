---@class (exact) DrawableSprite
---@field x number
---@field y number
---@field scale number
---@field flip_h boolean
---@field flip_v boolean
---@field graphics love.Image
---@field rgba number[]
DrawableSprite = {
	x = 0,
	y = 0,
	scale = 1,
	flip_h = false,
	flip_v = false,
	rgba = { 0, 0, 0, 0 },
}

function DrawableSprite:new(o)
	o = o or {}
	setmetatable(o, { __index = self })
	return o
end

function DrawableSprite:draw()
	love.graphics.setColor(WHITE)

	love.graphics.setShader(AS_SHADERS['blend_color'])
	AS_SHADERS['blend_color']:send("blendColor", self.rgba)

	local flip_h = self.flip_h and -1 or 1
	local flip_v = self.flip_v and -1 or 1
	love.graphics.draw(
		self.graphics,
		self.x,
		self.y,
		0,
		self.scale * flip_h,
		self.scale * flip_v
	)
	love.graphics.setShader()
end
