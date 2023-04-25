local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'tokyonight_night'
config.font = wezterm.font 'JetBrains Mono'
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
	{
		key = 'w',
		mods = 'SHIFT | CTRL',
		action = wezterm.action.CloseCurrentTab { confirm = false },
	},
}


return config
