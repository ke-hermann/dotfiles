-- Pull in  wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'

-- or, changing the font size and color scheme.
config.font = wezterm.font "CaskaydiaCove NF"
config.font_size = 13
-- smart tab bar behavior
config.hide_tab_bar_if_only_one_tab = true

if is_windows then
  -- Adjust path/flags if you installed Nu elsewhere
  config.default_prog = { 'nu.exe' }
end

-- Use CTRL+W as a "leader" key, similar to Vim
config.leader = {
  key = 'q',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}

config.keys = config.keys or {}
local function map(mods, key, action)
  table.insert(config.keys, { mods = mods, key = key, action = action })
end

-- splits
map('LEADER', 'v', act.SplitHorizontal { domain = 'CurrentPaneDomain' })
map('LEADER', 'h', act.SplitVertical { domain = 'CurrentPaneDomain' })
-- Vim-style pane navigation with Alt+h/j/k/l
map('ALT', 'h', act.ActivatePaneDirection 'Left')
map('ALT', 'j', act.ActivatePaneDirection 'Down')
map('ALT', 'k', act.ActivatePaneDirection 'Up')
map('ALT', 'l', act.ActivatePaneDirection 'Right')

-- scholarized theme, following the original spec
config.colors = {
  foreground = '#839496', -- base0
  background = '#002b36', -- base03

  ansi = {
    '#073642', -- base02 (black)
    '#dc322f', -- red
    '#859900', -- green
    '#b58900', -- yellow
    '#268bd2', -- blue
    '#d33682', -- magenta
    '#2aa198', -- cyan
    '#eee8d5', -- base2 (white)
  },

  brights = {
    '#002b36', -- base03 (bright black)
    '#cb4b16', -- orange (bright red)
    '#586e75', -- base01 (bright green)
    '#657b83', -- base00 (bright yellow)
    '#839496', -- base0 (bright blue)
    '#6c71c4', -- violet (bright magenta)
    '#93a1a1', -- base1 (bright cyan)
    '#fdf6e3', -- base3 (bright white)
  },
  }

-- Finally, return the configuration to wezterm:
return config
