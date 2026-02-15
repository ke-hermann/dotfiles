-- Pull in  wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- or, changing the font size and color scheme.
config.font = wezterm.font("CaskaydiaCove NF")
config.font_size = 13
-- smart tab bar behavior
config.hide_tab_bar_if_only_one_tab = true

if is_windows then
	-- Adjust path/flags if you installed Nu elsewhere
	config.default_prog = { "nu.exe" }
end

-- Use CTRL+W as a "leader" key, similar to Vim
config.leader = {
	key = "q",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

config.keys = config.keys or {}
local function map(mods, key, action)
	table.insert(config.keys, { mods = mods, key = key, action = action })
end

-- splits
map("LEADER", "v", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
map("LEADER", "h", act.SplitVertical({ domain = "CurrentPaneDomain" }))
-- Vim-style pane navigation with Alt+h/j/k/l
map("ALT", "h", act.ActivatePaneDirection("Left"))
map("ALT", "j", act.ActivatePaneDirection("Down"))
map("ALT", "k", act.ActivatePaneDirection("Up"))
map("ALT", "l", act.ActivatePaneDirection("Right"))

local canonical_solarized = require("canonical_solarized")
canonical_solarized.apply_to_config(config)

-- config.color_scheme = "Canonical Solarized Dark"
-- config.color_scheme = "rose-pine"
config.color_scheme = "Solarized (dark) (terminal.sexy)"

-- Finally, return the configuration to wezterm:
return config
