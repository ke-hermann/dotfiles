-- The Basics 
vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true


-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 600

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true


-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- save dialog on failure
vim.o.confirm = true
-- Speed up Lua module loading
vim.loader.enable()
-- Leader key (set before any keymaps)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ============================================================
-- 1. PLUGINS (vim.pack)
-- ============================================================
vim.pack.add({
  -- Theme
  'https://github.com/folke/tokyonight.nvim',
  -- keybinding helper display
  'https://github.com/folke/which-key.nvim',

  -- Telescope + dependency
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',

  -- Tim Pope's plugins
  'https://github.com/tpope/vim-surround',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',  -- enables :GBrowse for GitHub
  -- lsp server management
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  -- autocompletion 
  'https://github.com/saghen/blink.lib', 
  'https://github.com/saghen/blink.cmp' 
})

-- ============================================================
-- 2. BASIC OPTIONS
-- ============================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true

-- Mason package manager 
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- ============================================================
-- 3. THEME (TokyoNight)
-- ============================================================
require('tokyonight').setup({
  style = 'moon', -- storm | night | moon | day
  transparent = false,
  terminal_colors = true,
})
vim.cmd.colorscheme('tokyonight-night')

-- ============================================================
-- 4. TELESCOPE
-- ============================================================
local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
})

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })

-- Blink Completion Config 

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup()


-- ============================================================
-- 5. LSP (Built-in + nvim-lspconfig + mason)
-- ============================================================

-- Automatically enable specific language servers
vim.lsp.enable({ 'basedpyright', 'gopls', 'lua-language-server' })

-- Global LSP keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Show buffer diagnostics" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts, { desc = "Go to declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = "Go to definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = "Hover documentation" })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts, { desc = "Smart rename" })
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts, { desc = "Code actions" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = "Show references" })
  end
})


-- ============================================================
-- 6. MISC
-- ============================================================

-- Clear search highlight with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<<CR>')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Open Mason' })
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
