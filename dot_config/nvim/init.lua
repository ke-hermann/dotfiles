-- Bootstrap packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- Themes
	use 'lifepillar/vim-solarized8'
	use({ 'projekt0n/github-nvim-theme' })

	-- Plugins
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
	use "windwp/nvim-autopairs"
	-- Telescope, fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	-- automatic lsp configuration
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
				-- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}
	-- modeline
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- Lua
	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {}
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)

------------------
-- PLUGIN SETUP --
------------------

-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
	servers = {
		['lua_ls'] = { 'lua' },
		['rust_analyzer'] = { 'rust' },
		['pyright'] = { 'black' },
	}
})

lsp.ensure_installed({
	'pyright',
	'lua_ls'
})

lsp.setup()

-- CMP
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	mapping = {
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	}
})


-- Autopair
require("nvim-autopairs").setup()
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

-- Lualine
require('lualine').setup {
	options = {
		theme = 'horizon',
		component_separators = '|',
		section_separators = { left = '', right = '' },
	}
}

-- Treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "python", "lua", "vim", "vimdoc", "query" },
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = { enable = true }
}

-------------------------
-- GENERAL KEYBINDINGS --
-------------------------

-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set highlight on search
vim.opt.hlsearch = false
-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.opt.termguicolors = true
-- make long lines visible
vim.opt.wrap = true
-- Preserve the indentation of a virtual line
vim.opt.breakindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- enable exiting terminal-mode with `jk`
vim.cmd.tnoremap('jk <C-\\><C-n>')

-- colors
vim.opt.background = 'dark'
vim.cmd('colorscheme github_dark_high_contrast')

-------------
-- KEYMAPS --
-------------

vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '-', ':Explore<CR>')

-- [[ Telescope ]]
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
