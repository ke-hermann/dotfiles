vim.cmd [[packadd packer.nvim]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'lifepillar/vim-solarized8'
    use 'EdenEast/nightfox.nvim'
    use 'chriskempson/base16-vim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'

    -- Detect tabstop and shiftwidth automatically
    use   'tpope/vim-sleuth'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'folke/which-key.nvim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    }} end)

    -- Setup 
    vim.opt.guicursor = ""
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.smartindent = true

    vim.opt.wrap = false

    vim.opt.swapfile = false
    vim.opt.backup = false

    -- Set highlight on search
    vim.o.hlsearch = false
    vim.opt.incsearch = true

    -- Make line numbers default
    vim.opt.relativenumber = true

    -- Enable mouse mode
    vim.o.mouse = 'a'

    -- Sync clipboard between OS and Neovim.
    vim.o.clipboard = 'unnamedplus'

    -- Save undo history
    vim.o.undofile = true

    -- Case-insensitive searching UNLESS \C or capital in search
    vim.o.ignorecase = true
    vim.o.smartcase = true

    -- Keep signcolumn on by default
    vim.wo.signcolumn = 'yes'

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'

    -- NOTE: You should make sure your terminal supports this
    vim.o.termguicolors = true

    -- vim.cmd('set background=light')
    vim.cmd[[colorscheme base16-default-dark]]

    require('lualine').setup { options = { theme = 'base16' } }

    --  Telescope config
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find file" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep"})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "find buffer" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "search help tags" })

    require("which-key").setup()

    -- lsp config 
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()

    -- Make sure you setup `cmp` after lsp-zero

    local cmp = require('cmp')

    cmp.setup({
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({select = false}),
        }
    })

    -- treesitter  setup
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "python", "vim", "vimdoc", "query" },
        sync_install = false,
        auto_install = true
    }

    -- Keymaps 
    vim.keymap.set("i", "jk", "<Esc>")
    vim.keymap.set("t", "jk", [[<C-\><C-n>]]) -- normal mode mapping for term emulator
    vim.keymap.set('n', '<leader>ex', ":Ex %:p:h<CR>" , { desc = "open file explorer" })
    vim.keymap.set('n', '<leader>bl', ":set background=light<CR>", { desc = "set light background" })
    vim.keymap.set('n', '<leader>bd', ":set background=dark<CR>", { desc = "set dark  background" })
