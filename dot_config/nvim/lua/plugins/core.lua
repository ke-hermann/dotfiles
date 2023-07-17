return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "lifepillar/vim-solarized8" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      background = "light",
      colorscheme = "solarized8",
    },
  },

  vim.keymap.set("i", "jk", "<Esc>"),

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = { theme = "solarized_light" },
      }
    end,
  },
}
