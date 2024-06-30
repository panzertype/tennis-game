---@class (exact) GameState
---@field states any
GameState = {}

function GameState:new(states)
	self.states = states
	return self
end

function GameState:update(dt)
	self.states[#self.states]:update(dt)
end

function GameState:draw()
	for i = 1, #self.states do
		self.states[i]:draw()
	end
end

function GameState:push(state)
	table.insert(self.states, state)
end

function GameState:pop()
	local length = #self.states
	assert(length >= 1)
	table.remove(self.states, length)
end
