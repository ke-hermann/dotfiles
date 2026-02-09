-- Pull in  wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'

-- default geometry
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font = wezterm.font "CaskaydiaCove NF"
config.font_size = 13
config.color_scheme = 'Solarized (dark) (terminal.sexy)'
-- smart tab bar behavior
config.hide_tab_bar_if_only_one_tab = true

if is_windows then
  -- Adjust path/flags if you installed Nu elsewhere
  config.default_prog = { 'nu.exe' }
end

-- Use CTRL+W as a "leader" key, similar to Vim
config.leader = {
  key = 'x',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}

config.keys = config.keys or {}
local function map(mods, key, action)
  table.insert(config.keys, { mods = mods, key = key, action = action })
end

-- splits
map('LEADER', '3', act.SplitHorizontal { domain = 'CurrentPaneDomain' })
map('LEADER', '2', act.SplitVertical { domain = 'CurrentPaneDomain' })
-- Vim-style pane navigation with Alt+h/j/k/l
map('ALT', 'h', act.ActivatePaneDirection 'Left')
map('ALT', 'j', act.ActivatePaneDirection 'Down')
map('ALT', 'k', act.ActivatePaneDirection 'Up')
map('ALT', 'l', act.ActivatePaneDirection 'Right')

-- Finally, return the configuration to wezterm:
return config
