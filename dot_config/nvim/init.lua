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
	-- Plugins
	use 'tpope/vim-surround'
	use 'lifepillar/vim-solarized8'
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
	}
})

local cmp = require('cmp')

cmp.setup({
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = false }),
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
		theme = 'solarized_light',
		component_separators = '|',
		section_separators = { left = '', right = '' },
	}
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


-- colors
vim.o.background = 'light'
vim.api.nvim_command('colorscheme solarized8')


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
