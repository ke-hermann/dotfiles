local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Solarized Light (Gogh)'
config.font = wezterm.font 'Berkeley Mono'
config.font_size = 13
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
	{
		key = 'w',
		mods = 'SHIFT | CTRL',
		action = wezterm.action.CloseCurrentTab { confirm = false },
	},
}


return config
