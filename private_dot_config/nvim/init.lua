-- init.lua
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>hl', ':nohl<CR>')
vim.keymap.set('n', '<leader>td', ':set background=dark<CR>')
vim.keymap.set('n', '<leader>tl', ':set background=light<CR>')
vim.keymap.set('i', 'jk', '<Esc>')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "vague2k/vague.nvim" },
	{ "stevearc/oil.nvim" },
	{ "echasnovski/mini.pick" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "neovim/nvim-lspconfig" },
	{ "chomosuke/typst-preview.nvim" },
	{ "mason-org/mason.nvim" },
	{ "OXY2DEV/markview.nvim" },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000, opts = ..., },
	{ "folke/neodev.nvim",        opts = {} }
})

vim.o.background = "light"
require("gruvbox").setup({
	contrast = "soft", -- can be "hard", "soft" or empty string
})
vim.cmd("colorscheme gruvbox")

-- Everything below is exactly the same as your original config
require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "lua", "python", "clojure" },
	highlight = { enable = true }
})

require "oil".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>b', ":Pick buffers<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>g', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.lsp.enable({ "lua_ls", "pyright" })

require('lualine').setup({ options = { theme = 'gruvbox' } })

-- Enable LSP omni completion on buffer attach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local bufnr = args.buf
		vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
	end,
})
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- LSP config (these will be started via lspconfig internally when needed)
vim.lsp.enable('pyright')
vim.lsp.enable('lua-language-server')
vim.lsp.enable('nushell')

require("mason").setup()
