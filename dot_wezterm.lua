local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Default Dark (base16)'
config.font = wezterm.font 'Iosevka'
config.font_size = 14
config.window_close_confirmation = 'NeverPrompt'
config.warn_about_missing_glyphs = false

config.keys = {
	{
		key = 'w',
		mods = 'SHIFT | CTRL',
		action = wezterm.action.CloseCurrentTab { confirm = false },
	},
}


return config
