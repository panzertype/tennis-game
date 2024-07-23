JSON = require("lib.json")
require("lib.strict")

require("src.constants")

require("src.data.ball")
require("src.data.opponent")
require("src.data.player")

require("src.utils")

require("src.assets")
require("src.game_config")

require("src.engine.drawable_sprite")

require("src.ui.button")
require("src.ui.stack")
require("src.ui.range")
require("src.ui.text")

require("src.entities.tennisist")
require("src.entities.opponent")
require("src.entities.ball")

require("src.states.pause_state")
require("src.states.main_menu_state")
require("src.states.settings_state")
require("src.states.playing_state")
require("src.states.countdown_state")
require("src.states.customize_tennisists_state")
require("src.states.color_picker_state")
require("src.game_state")
