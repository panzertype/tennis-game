---@class (exact) GameState
---@field player Player
---@field opponent Opponent
---@field ball Ball
GameState = {}

local PLAYER_WIDTH = 26
local PLAYER_HEIGHT = 24
local BALL_SIZE = 10
local BALL_SPEED_MULTIPLIER = 1.03
local RACKET_HIT_SOUND = love.audio.newSource("assets/racket-hit.mp3", "stream")

function GameState:new()
    self.player = Player:new{ x = 0, y = 50, width = PLAYER_WIDTH, height = PLAYER_HEIGHT }
    self.opponent = Opponent:new{ x = RENDER_TARGET_WIDTH - PLAYER_WIDTH, y = 50, width = PLAYER_WIDTH, height = PLAYER_HEIGHT }
    self.ball = Ball:new{ x = RENDER_TARGET_WIDTH / 2 - BALL_SIZE, y = RENDER_TARGET_HEIGHT / 2 - BALL_SIZE, width = BALL_SIZE, height = BALL_SIZE, dx = 0, dy = 0 }
    self.ball.dy = math.random(-50, 50)
    local dx = math.random(140, 200)
    self.ball.dx = math.random() % 2 and dx or -dx
    return self
end

function GameState:update(dt)
    self:handle_collision()
    self.ball:update(dt)
    self.player:update(dt)
    self.opponent:update(dt)
end

function GameState:draw()
    love.graphics.setColor(0, 1, 1)
    love.graphics.line(RENDER_TARGET_WIDTH / 2, 0, RENDER_TARGET_WIDTH / 2, RENDER_TARGET_HEIGHT)
    self.player:draw()
    self.opponent:draw()
    self.ball:draw()
end

---@private
function GameState:handle_collision()
    if EnitiesCollide(self.player, self.ball) then
	RACKET_HIT_SOUND:play()
	print(self.ball.x, self.ball.y)

	self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER
	self.ball.x = self.player.x + PLAYER_WIDTH

	-- keep velocity going in the same direction, but randomize it
	if self.ball.dy < 0 then
	    self.ball.dy = -math.random(10, 150)
	else
	    self.ball.dy = math.random(10, 150)
	end
    end

    if EnitiesCollide(self.opponent, self.ball) then
	RACKET_HIT_SOUND:play()
	print(self.ball.x, self.ball.y)

	self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER
	self.ball.x = self.opponent.x - BALL_SIZE

	-- keep velocity going in the same direction, but randomize it
	if self.ball.dy < 0 then
	    self.ball.dy = -math.random(10, 150)
	else
	    self.ball.dy = math.random(10, 150)
	end
    end

    if self.ball.y <= 0 then
	self.ball.y = 0
	self.ball.dy = -self.ball.dy
    end

    if self.ball.y >= RENDER_TARGET_HEIGHT - BALL_SIZE then
	self.ball.y = RENDER_TARGET_HEIGHT - BALL_SIZE
	self.ball.dy = -self.ball.dy
    end

    if self.ball.x < 0 or self.ball.x + BALL_SIZE > RENDER_TARGET_WIDTH then
	self.ball.x = RENDER_TARGET_WIDTH / 2 - BALL_SIZE
	self.ball.y = RENDER_TARGET_HEIGHT / 2 - BALL_SIZE
	self.ball.dy = math.random(-50, 50)
	local dx = math.random(140, 200)
	self.ball.dx = math.random() % 2 and dx or -dx
    end
end
