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
		}
})

-- Everything below is exactly the same as your original config
require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "lua", "python", "clojure", "rust", "haskell", "cpp" },
	highlight = { enable = true }
})

require "oil".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>b', ":Pick buffers<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>g', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.lsp.enable({ "lua_ls", "biome", "tinymist", "emmetls" })

require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")


require('lualine').setup({options = { theme = 'codedark' }} )

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
