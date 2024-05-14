GameState = {}

function GameState:new()
	self.player1 = Player:new{ x = 50, y = 50 }
	self.player2 = Player:new{ x = 80, y = 80 }
	return self
end

function GameState:update(dt)
	self.player1:update(dt)
	self.player2:update(dt)
end

function GameState:draw()
	self.player1:draw()
	self.player2:draw()
end
