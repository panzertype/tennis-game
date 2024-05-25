function Collides(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end

function EntitiesCollide(a, b)
    return Collides(a.x, a.y, a.width, a.height, b.x, b.y, b.width, b.height)
end

---@param hex string
---@return number[]
function HexToColor(hex, value)
    return {
	tonumber(string.sub(hex, 2, 3), 16)/256,
	tonumber(string.sub(hex, 4, 5), 16)/256,
	tonumber(string.sub(hex, 6, 7), 16)/256,
	value or 1
    }
end

---@param rgb number[]
---@param a number
---@return number[]
function Rgba(rgb, a)
    return { rgb[1], rgb[2], rgb[3], a }
end
