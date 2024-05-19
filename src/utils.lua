function Collides(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end

function EnitiesCollide(a, b)
    return Collides(a.x, a.y, a.width, a.height, b.x, b.y, b.width, b.height)
end
