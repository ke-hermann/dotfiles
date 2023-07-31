local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.window_close_confirmation = 'NeverPrompt'
config.warn_about_missing_glyphs = false

-- Spawn powershell on windows
if package.config:sub(1, 1) == '\\' then
	config.default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'}
	config.font_size = 12
else
	config.font_size = 14
end

config.color_scheme = 'Default Dark (base16)'

config.keys = {
	{
		key = 'w',
		mods = 'SHIFT | CTRL',
		action = wezterm.action.CloseCurrentTab { confirm = false },
	},
}


return config
