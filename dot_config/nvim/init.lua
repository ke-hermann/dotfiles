-- Bootstrap LAZY

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- install plugins

require("lazy").setup({
  -- theme
  "lifepillar/vim-solarized8",
  "ellisonleao/gruvbox.nvim",
  "cocopon/iceberg.vim",
  "nyoom-engineering/oxocarbon.nvim",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- UX helpers
  "folke/which-key.nvim",
  -- Language Server Protocol
  "williamboman/mason.nvim",
  { 'williamboman/mason-lspconfig.nvim' },
  -- File Navigation
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  -- File Explorer with vim keybindings
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- tpope plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "tpope/vim-dispatch",
  "Olical/conjure",
  "clojure-vim/vim-jack-in",

  -- LSP zero config
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },

  'nvim-treesitter/nvim-treesitter',
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
})

-- Basic Settings

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.guicursor = ""
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.relativenumber = true
vim.opt.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.background = "dark" -- set this to dark or light
vim.o.termguicolors = true

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
})

vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "catppuccin"


--  Telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find file" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "find buffer" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "search help tags" })

require("which-key").setup()

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = ' ', right = ' ' },
  }
}

-- noice setup 
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

-- Lsp Config

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  -- lsp_zero.buffer_autoformat()
end)

-- enable TAB completion and ENTER confirmation
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  })
})

-- setup servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Treesitter config
--
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'python', 'c', 'cpp', 'lua', 'clojure' },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
    prefer_gk_over_autocmd = true,
  },
  cintegration = {
    enable = true,
    highlight_ignores = { 'Bar', 'Comment' },
  },
  autopairs = {
    enable = true,
  },
}

-- Keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", [[<C-\><C-n>]]) -- normal mode mapping for term emulator
vim.keymap.set('n', '<leader>ex', ":Ex %:p:h<CR>", { desc = "open file explorer" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- Formatting Configs 
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  desc = "Auto-format Python files after saving",
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !black --preview -q " .. fileName)
    vim.cmd(":silent !isort --profile black --float-to-top -q " .. fileName)
    vim.cmd(":silent !docformatter --in-place --black " .. fileName)
  end,
  group = autocmd_group,
})
