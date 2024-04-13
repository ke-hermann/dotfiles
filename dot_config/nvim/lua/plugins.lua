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
	-- Themes
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function() end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
	},

	{ "tjdevries/colorbuddy.nvim" },
	{ 'projekt0n/github-nvim-theme' },

	-- UX helpers
	"folke/which-key.nvim",
	-- File Navigation
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = " ", right = " " },
					section_separators = { left = " ", right = " " },
				},
			})
		end,
	},
	-- File Explorer with vim keybindings
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	-- tpope plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-surround",
	"tpope/vim-sleuth",
	"tpope/vim-dispatch",
	"Olical/conjure",
	"clojure-vim/vim-jack-in",
	"nvim-treesitter/nvim-treesitter",

	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{ "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	{
		"stevearc/conform.nvim",
		opts = {},
	},

	-- nicer status messages
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{ "tomasky/bookmarks.nvim" },
})
