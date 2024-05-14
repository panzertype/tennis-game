---@class (exact) GameState
---@field player1 Player
---@field player2 Player
---@field ball Ball
GameState = {}

local PLAYER_WIDTH = 10
local PLAYER_HEIGHT = 40
local BALL_SIZE = 10
local BALL_SPEED_MULTIPLIER = 1.03

function GameState:new()
	self.player1 = Player:new{ x = 0, y = 50, width = PLAYER_WIDTH, height = PLAYER_HEIGHT }
	self.player2 = Player:new{ x = G_WINDOW_WIDTH - PLAYER_WIDTH, y = 50, width = PLAYER_WIDTH, height = PLAYER_HEIGHT }
	self.ball = Ball:new{ x = G_WINDOW_WIDTH / 2 - BALL_SIZE, y = G_WINDOW_HEIGHT / 2 - BALL_SIZE, width = BALL_SIZE, height = BALL_SIZE, dx = 0, dy = 0 }
    self.ball.dy = math.random(-50, 50)
	local dx = math.random(140, 200)
	self.ball.dx = math.random() % 2 and dx or -dx
	return self
end

function GameState:update(dt)
	self:handle_collision()
	self.ball:update(dt)
	self.player1:update(dt)
	self.player2:update(dt)
end

function GameState:draw()
    love.graphics.setColor(0, 1, 1)
	love.graphics.line(G_WINDOW_WIDTH / 2, 0, G_WINDOW_WIDTH / 2, G_WINDOW_HEIGHT)
	self.player1:draw()
	self.player2:draw()
	self.ball:draw()
end

---@private
function GameState:handle_collision()
	if EnitiesCollide(self.player1, self.ball) then

		print(self.ball.x, self.ball.y)


		self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER
		self.ball.x = self.player1.x + PLAYER_WIDTH

		-- keep velocity going in the same direction, but randomize it
		if self.ball.dy < 0 then
			self.ball.dy = -math.random(10, 150)
		else
			self.ball.dy = math.random(10, 150)
		end
	end

	if EnitiesCollide(self.player2, self.ball) then

		print(self.ball.x, self.ball.y)

		self.ball.dx = -self.ball.dx * BALL_SPEED_MULTIPLIER
		self.ball.x = self.player2.x - BALL_SIZE

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

	if self.ball.y >= G_WINDOW_HEIGHT - BALL_SIZE then
		self.ball.y = G_WINDOW_HEIGHT - BALL_SIZE
		self.ball.dy = -self.ball.dy
	end

	if self.ball.x < 0 or self.ball.x > G_WINDOW_WIDTH then
		self.ball.x = G_WINDOW_WIDTH / 2 - BALL_SIZE
		self.ball.y = G_WINDOW_HEIGHT / 2 - BALL_SIZE
		self.ball.dy = math.random(-50, 50)
		local dx = math.random(140, 200)
		self.ball.dx = math.random() % 2 and dx or -dx
	end
end
