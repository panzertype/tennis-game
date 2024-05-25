---@class (exact) PlayingState
---@field player Player
---@field opponent Opponent
---@field ball Ball
PlayingState = {}

local PLAYER_SPEED = 100
local PLAYERS_WIDTH = 26
local PLAYERS_HEIGHT = 24
local PLAYERS_PADDING = 16
local PLAYERS_STARTING_Y = RENDER_TARGET_HEIGHT / 2 - PLAYERS_HEIGHT / 2

local BALL_SIZE = 5
local BALL_SPEED_MULTIPLIER = 1.03

local SCORE_PADDING = 50

local FONT = AS_FONTS['medium']
local player_score = 0
local opponent_score = 0

function PlayingState:new(o)
    o = o or {}

    self.player = Player:new{
	x = PLAYERS_PADDING,
	y = PLAYERS_STARTING_Y,
	width = PLAYERS_WIDTH,
	height = PLAYERS_HEIGHT
    }
    self.opponent = Opponent:new{
	x = RENDER_TARGET_WIDTH - PLAYERS_WIDTH - PLAYERS_PADDING,
	y = PLAYERS_STARTING_Y,
	width = PLAYERS_WIDTH,
	height = PLAYERS_HEIGHT
    }
    self.ball = Ball:new{
	x = RENDER_TARGET_WIDTH / 2 - BALL_SIZE,
	y = RENDER_TARGET_HEIGHT / 2 - BALL_SIZE,
	width = BALL_SIZE,
	height = BALL_SIZE,
	dx = 0,
	dy = 0
    }
    self.ball.dy = math.random(-50, 50)
    local dx = math.random(140, 200)
    self.ball.dx = math.random() % 2 and dx or -dx

    setmetatable(o, { __index = self })
    return o
end

function PlayingState:update(dt)
    if love.keyboard.wasPressed("escape") then
	local pause_state = PauseState:new()
	GAME_STATE:push(pause_state)
    end

    self:handle_collision()
    self.ball:update(dt)
    self:update_player(dt)
    self.opponent:update(dt, self.ball)
end

---@private
function PlayingState:update_player(dt)
    if love.keyboard.isDown("up") then
	local next_player_position_y = self.player.y - PLAYER_SPEED * dt
	if next_player_position_y >= 0 then
	    self.player.y = next_player_position_y
	end
    end
    if love.keyboard.isDown("down") then
	local next_player_position_y = self.player.y + PLAYER_SPEED * dt
	if next_player_position_y + self.player.height <= RENDER_TARGET_HEIGHT then
	    self.player.y = next_player_position_y
	end
    end
end

function PlayingState:draw()
    love.graphics.setColor(AS_COLORS['white'])
    love.graphics.line(RENDER_TARGET_WIDTH / 2, 0, RENDER_TARGET_WIDTH / 2, RENDER_TARGET_HEIGHT)
    self:draw_score()
    self.player:draw()
    self.opponent:draw()
    self.ball:draw()
end

---@private
function PlayingState:draw_score()
    love.graphics.setColor(AS_COLORS['white'])
    local player_score_text = tostring(player_score)
    local opponent_score_text = tostring(opponent_score)
    local half_font_height = FONT:getHeight() / 2
    love.graphics.setFont(FONT)
    love.graphics.print(
	player_score_text,
	RENDER_TARGET_WIDTH / 2 - SCORE_PADDING - FONT:getWidth(player_score_text),
	RENDER_TARGET_HEIGHT / 2 - half_font_height
    )
    love.graphics.print(
	opponent_score_text,
	RENDER_TARGET_WIDTH / 2 + SCORE_PADDING,
	RENDER_TARGET_HEIGHT / 2 - half_font_height
    )
end

---@private
function PlayingState:handle_collision()
    if EntitiesCollide(self.player, self.ball) then
	AS_AUDIO['racket_hit']:play()
	print(self.ball.x, self.ball.y)

	self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER
	self.ball.x = self.player.x + PLAYERS_WIDTH

	-- keep velocity going in the same direction, but randomize it
	if self.ball.dy < 0 then
	    self.ball.dy = -math.random(10, 150)
	else
	    self.ball.dy = math.random(10, 150)
	end
    end

    if EntitiesCollide(self.opponent, self.ball) then
	AS_AUDIO['racket_hit']:play()
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
