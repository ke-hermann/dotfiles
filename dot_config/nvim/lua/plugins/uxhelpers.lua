-- UX helpers
return {
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},
	-- File Navigation
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			--  Telescope config
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "search help tags" })
		end,
	},
	-- File Explorer with vim keybindings
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
