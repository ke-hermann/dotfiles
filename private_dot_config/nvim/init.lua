require("base")
require("config.lazy")

vim.o.termguicolors = true
vim.o.background = 'dark'
require('solarized').setup(opts)
vim.cmd.colorscheme 'solarized'
