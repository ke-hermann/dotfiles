local wezterm = require("wezterm")
local config = {}

config.window_close_confirmation = "NeverPrompt"
config.warn_about_missing_glyphs = false

config.font = wezterm.font("Berkeley Mono Regular")

config.color_scheme = 'Oxocarbon Dark (Gogh)'
config.use_fancy_tab_bar = false

config.hide_tab_bar_if_only_one_tab = true

-- Spawn powershell on windows
if package.config:sub(1, 1) == "\\" then
	config.default_prog = { "powershell" }
	config.font_size = 13
else
	config.font_size = 15
end

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
