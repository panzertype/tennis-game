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
local SCORE_PADDING = 50

local font = love.graphics.newFont(14)
local player_score = 0
local opponent_score = 0

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
    self.opponent:update(dt, self.ball)
end

function GameState:draw()
    love.graphics.setColor(0, 1, 1)
    love.graphics.line(RENDER_TARGET_WIDTH / 2, 0, RENDER_TARGET_WIDTH / 2, RENDER_TARGET_HEIGHT)
    self:draw_score()
    self.player:draw()
    self.opponent:draw()
    self.ball:draw()
end

---@private
function GameState:draw_score()
    local player_score_text = tostring(player_score)
    local opponent_score_text = tostring(opponent_score)
    local half_font_height = font:getHeight() / 2
    love.graphics.print(
	player_score_text,
	RENDER_TARGET_WIDTH / 2 - SCORE_PADDING - font:getWidth(player_score_text),
	RENDER_TARGET_HEIGHT / 2 - half_font_height
    )
    love.graphics.print(
	opponent_score_text,
	RENDER_TARGET_WIDTH / 2 + SCORE_PADDING,
	RENDER_TARGET_HEIGHT / 2 - half_font_height
    )
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

    local opponent_scored = self.ball.x < 0
    local player_scored = self.ball.x + BALL_SIZE > RENDER_TARGET_WIDTH

    if opponent_scored or player_scored then
	self.ball.x = RENDER_TARGET_WIDTH / 2 - BALL_SIZE
	self.ball.y = RENDER_TARGET_HEIGHT / 2 - BALL_SIZE
	self.ball.dy = math.random(-50, 50)
	local dx = math.random(140, 200)
	self.ball.dx = math.random() % 2 and dx or -dx

	if opponent_scored then
	    opponent_score = opponent_score + 1
	else
	    player_score = player_score + 1
	end
    end
end
