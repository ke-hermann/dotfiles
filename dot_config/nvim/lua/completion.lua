-- Treesitter config
--
require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "c", "cpp", "lua", "clojure", "go" },
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
		highlight_ignores = { "Bar", "Comment" },
	},
	autopairs = {
		enable = true,
	},
})

-- LSP Config
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "lua_ls", "gopls" },
	handlers = {
		lsp_zero.default_setup,
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		go = { "goimports", "gofmt" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
