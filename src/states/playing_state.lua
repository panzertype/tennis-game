---@class (exact) PlayingState: Entity
---@field private player_color RGBA
---@field private opponent_color RGBA
---@field private player Tennisist
---@field private opponent Opponent
---@field private ball Ball
PlayingState = {}

local players_padding = 16

local player_starting_y = RENDER_TARGET_HEIGHT / 2 - PlayerData.hitbox_height / 2
local opponent_starting_y = RENDER_TARGET_HEIGHT / 2 - OpponentData.hitbox_height / 2

local player_starting_x = players_padding
local opponent_starting_x = RENDER_TARGET_WIDTH - OpponentData.hitbox_width - players_padding

local score_padding = 50

local font = AS_FONTS['medium']
local player_score = 0
local opponent_score = 0

function PlayingState:new(o)
	o = o or {}

	self.player = Tennisist:new {
		x = player_starting_x,
		y = player_starting_y,
		width = PlayerData.hitbox_width,
		height = PlayerData.hitbox_height,
		sprite = DrawableSprite:new({
			graphics = AS_GRAPHICS["tennisist"],
			rgba = GAME_CONFIG["player_color"],
			scale = 2
		})
	}
	self.opponent = Opponent:new {
		x = opponent_starting_x,
		y = opponent_starting_y,
		speed = OpponentData.base_speed,
		width = OpponentData.hitbox_width,
		height = OpponentData.hitbox_height,
		sprite = DrawableSprite:new({
			graphics = AS_GRAPHICS["tennisist"],
			rgba = GAME_CONFIG["opponent_color"],
			flip_h = true,
			scale = 2
		})
	}
	self.ball = Ball:new {
		x = RENDER_TARGET_WIDTH / 2 - BallData.hitbox_size,
		y = RENDER_TARGET_HEIGHT / 2 - BallData.hitbox_size,
		width = BallData.hitbox_size,
		height = BallData.hitbox_size,
		dx = math.random() % 2 and self:get_ball_random_dx() or -self:get_ball_random_dx(),
		dy = math.random(BallData.min_starting_dy, BallData.max_starting_dy)
	}

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
		local next_player_position_y = self.player.y - PlayerData.base_speed * dt
		if next_player_position_y >= 0 then
			self.player.y = next_player_position_y
		end
	end
	if love.keyboard.isDown("down") then
		local next_player_position_y = self.player.y + PlayerData.base_speed * dt
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
	local half_font_height = font:getHeight() / 2
	love.graphics.setFont(font)
	love.graphics.print(
		player_score_text,
		RENDER_TARGET_WIDTH / 2 - score_padding - font:getWidth(player_score_text),
		RENDER_TARGET_HEIGHT / 2 - half_font_height
	)
	love.graphics.print(
		opponent_score_text,
		RENDER_TARGET_WIDTH / 2 + score_padding,
		RENDER_TARGET_HEIGHT / 2 - half_font_height
	)
end

---@private
function PlayingState:get_ball_random_dy()
	return math.random(BallData.min_dy, BallData.max_dy)
end

---@private
function PlayingState:get_ball_random_dx()
	return math.random(BallData.min_dx, BallData.max_dx)
end

---@private
function PlayingState:bounce_ball_y()
	if self.ball.dy < 0 then
		self.ball.dy = -self:get_ball_random_dy()
	else
		self.ball.dy = self:get_ball_random_dy()
	end
end

---@private
function PlayingState:handle_collision()
	if EntitiesCollide(self.player, self.ball) then
		AS_AUDIO['racket_hit']:stop()
		AS_AUDIO['racket_hit']:play()
		print("Player hit: ", self.ball.x, self.ball.y)

		self.ball.dx = -self.ball.dx * BallData.speed_multiplier
		self.ball.x = self.player.x + self.player.width

		self:bounce_ball_y()
	end

	if EntitiesCollide(self.opponent, self.ball) then
		AS_AUDIO['racket_hit']:stop()
		AS_AUDIO['racket_hit']:play()
		print("Opponent hit: ", self.ball.x, self.ball.y)

		self.ball.dx = -self.ball.dx * BallData.speed_multiplier
		self.ball.x = self.opponent.x - BallData.hitbox_size

		self:bounce_ball_y()
	end

	if self.ball.y <= 0 then
		self.ball.y = 0
		self.ball.dy = -self.ball.dy
	end

	if self.ball.y >= RENDER_TARGET_HEIGHT - BallData.hitbox_size then
		self.ball.y = RENDER_TARGET_HEIGHT - BallData.hitbox_size
		self.ball.dy = -self.ball.dy
	end

	local opponent_scored = self.ball.x < 0
	local player_scored = self.ball.x + BallData.hitbox_size > RENDER_TARGET_WIDTH

	if opponent_scored or player_scored then
		self.ball.x = player_scored and player_starting_x + self.player.width - 1 or opponent_starting_x - BallData.hitbox_size
		self.ball.y = RENDER_TARGET_HEIGHT / 2 - BallData.hitbox_size
		self.ball.dy = self:get_ball_random_dy()
		local dx = self:get_ball_random_dx()
		self.ball.dx = player_scored and dx or -dx

		if opponent_scored then
			opponent_score = opponent_score + 1
		else
			player_score = player_score + 1
		end

		self.player.y = player_starting_y
		self.opponent.y = opponent_starting_y
		GAME_STATE:push(CountdownState:new({ count_from = 3, count_till = 0 }))
	end
end
