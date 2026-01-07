return {
	{
		"catppuccin/nvim",

	},
	{

		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.opt.background = "dark" -- set this to dark or light
			vim.cmd("colorscheme rose-pine")
			-- Make Neovim background transparent
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	}
}
