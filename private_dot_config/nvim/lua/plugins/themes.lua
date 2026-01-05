return {
	{
		"catppuccin/nvim",

	},
	{
		"nyoom-engineering/oxocarbon.nvim" 
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.opt.background = "dark" -- set this to dark or light
			vim.cmd[[colorscheme oxocarbon]]
		end
	}
}
