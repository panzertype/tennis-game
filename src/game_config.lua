---@alias GameConfig { player_color?: number[], opponent_color?: number, music_volume: number, sfx_volume: number }

---@type GameConfig
GAME_CONFIG = {
	['player_color'] = nil,
	['opponent_color'] = nil,
	['sfx_volume'] = 0.8,
	['music_volume'] = 0.1
}

function LOAD_CONFIG()
	if love.filesystem.getInfo(SAVE_FILE_NAME) then
		local json_string = love.filesystem.read(SAVE_FILE_NAME)
		GAME_CONFIG = JSON.decode(json_string)
	else
		SAVE_CONFIG()
	end
end

function SAVE_CONFIG()
	local json_string = JSON.encode(GAME_CONFIG)
	love.filesystem.write(SAVE_FILE_NAME, json_string)
end
