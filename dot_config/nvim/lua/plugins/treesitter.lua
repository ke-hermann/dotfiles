return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
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
		end,
	},
}
