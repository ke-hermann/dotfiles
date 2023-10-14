local wezterm = require 'wezterm'
local config = {}

config.window_close_confirmation = 'NeverPrompt'
config.warn_about_missing_glyphs = false
-- config.default_prog = { 'nu'}

-- Spawn powershell on windows
if package.config:sub(1, 1) == '\\' then
   config.font = wezterm.font 'Cascadia Code'
   config.font_size = 12
else
   config.font = wezterm.font 'JetBrains Mono'
   config.font_size = 15
end

config.color_scheme = 'Default Dark (base16)'

config.use_fancy_tab_bar = false

config.hide_tab_bar_if_only_one_tab = true

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
   {
      key = 'w',
      mods = 'SHIFT | CTRL',
      action = wezterm.action.CloseCurrentTab { confirm = false },
   },
   {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
   },
   {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
   },
}


return
    config
