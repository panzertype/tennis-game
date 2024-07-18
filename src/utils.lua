---@param x1 number
---@param y1 number
---@param w1 number
---@param h1 number
---@param x2 number
---@param y2 number
---@param w2 number
---@param h2 number
function Collides(x1, y1, w1, h1, x2, y2, w2, h2)
	return
		x1 < x2 + w2 and
		x2 < x1 + w1 and
		y1 < y2 + h2 and
		y2 < y1 + h1
end

function EntitiesCollide(a, b)
	return Collides(
		a.x, a.y, a.width, a.height,
		b.x, b.y, b.width, b.height
	)
end

---@param hex string
---@param alpha? string
---@return RGBA 
function HexToColor(hex, alpha)
	return {
		tonumber(string.sub(hex, 2, 3), 16) / 256,
		tonumber(string.sub(hex, 4, 5), 16) / 256,
		tonumber(string.sub(hex, 6, 7), 16) / 256,
		alpha or 1
	}
end

---@param rgb RGB
---@param alpha number
---@return RGBA[]
function Rgba(rgb, alpha)
	return { rgb[1], rgb[2], rgb[3], alpha }
end

function DrawBackdrop()
	love.graphics.setColor(Rgba(AS_COLORS["black"], 0.6))
	love.graphics.rectangle("fill", 0, 0, RENDER_TARGET_WIDTH, RENDER_TARGET_HEIGHT)
end