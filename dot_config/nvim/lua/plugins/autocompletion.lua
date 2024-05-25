-- autocompletion support
return {

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			-- LSP Config
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)
		end,
	},

	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls", "gopls", "vimls" },
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end,
	},

	{ "tomasky/bookmarks.nvim" },
}
