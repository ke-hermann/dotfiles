return {
	{
		"williamboman/mason.nvim",
		config = function()
			-- Mason setup
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			-- Automatically ensure LSP servers are installed
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls"}, -- Add your preferred LSP servers
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim" },
		config = function()
			-- LSP setup
			local lspconfig = require("lspconfig")

			-- Basic LSP server setup
			vim.lsp.enable('pyright')
			vim.lsp.enable('lua-language-server')
		end,
	},
	{
		"hrsh7th/nvim-cmp", -- Completion plugin (useful with LSP)
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp", -- Completion source for LSP
	},
	{
		"L3MON4D3/LuaSnip", -- Snippet engine (optional)
	},


}
