local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13
config.window_close_confirmation = 'NeverPrompt'
config.warn_about_missing_glyphs = false

-- config.color_scheme = 'Builtin Solarized Light'
local dimmer = { brightness = 0.1 }

config.background = {
	{
		source = {
			File = wezterm.home_dir .. '/.local/resources/shodan2.jpg'
		},
		hsb = dimmer,
	}
}

config.keys = {
	{
		key = 'w',
		mods = 'SHIFT | CTRL',
		action = wezterm.action.CloseCurrentTab { confirm = false },
	},
}


return config
