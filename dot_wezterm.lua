local wezterm = require("wezterm")
local config = {}

config.window_close_confirmation = "NeverPrompt"
config.warn_about_missing_glyphs = false

config.font = wezterm.font("Fira Code Retina")
config.color_scheme = 'iceberg-dark'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 14


config.keys = {
	{
		key = "w",
		mods = "SHIFT | CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

return config
