require("src.shaders.blend_color_shader")
require("src.shaders.scanlines_shader")

AS_GRAPHICS = {
    ['tennisist'] = love.graphics.newImage('assets/graphics/tennisist.png'),
}

AS_FONTS = {
    ['small'] = love.graphics.newFont('assets/fonts/Silkscreen-Regular.ttf', 8),
    ['medium'] = love.graphics.newFont('assets/fonts/Silkscreen-Regular.ttf', 16),
    ['large'] = love.graphics.newFont('assets/fonts/Silkscreen-Regular.ttf', 32),
}

AS_AUDIO = {
    ['music'] = love.audio.newSource('assets/audio/rhodes.mp3', 'stream'),
    ['racket_hit'] = love.audio.newSource('assets/audio/racket-hit.mp3', 'stream'),
}

AS_SHADERS = {
    ['scanlines'] = love.graphics.newShader(SCANLINES_SHADER),
    ['blend_color'] = love.graphics.newShader(BLEND_COLOR_SHADER),
}
