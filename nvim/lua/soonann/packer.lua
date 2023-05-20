-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- PACKER (self managed)
    use 'wbthomason/packer.nvim'

    -- NAVIGATION
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    } -- telescope navigation
    use('theprimeagen/harpoon') -- harpoon

    -- GIT/VERSIONING
    use('tpope/vim-fugitive') -- git wrapper
    use('mbbill/undotree') -- undo to specific changes
    use('airblade/vim-gitgutter') -- git changes in the gutter

    -- VIM BE GOOD
    use('ThePrimeagen/vim-be-good')

    -- LSP
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) -- Treesitter
    use 'nvim-treesitter/nvim-treesitter-context' -- Sticky headers
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    } -- lsp zero
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    } -- flutter language support
    use 'mfussenegger/nvim-jdtls' -- java language support
    use 'fatih/vim-go' -- golang language support
    use 'hashivim/vim-terraform' -- terraform language support
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }) -- markdown preview support
    use "lukas-reineke/lsp-format.nvim" -- format on save

    -- QOL
    use('scrooloose/nerdcommenter') -- comments with nerd commenter
    use('tpope/vim-surround')
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    } -- auto create pairs [{()}]

    use("windwp/nvim-ts-autotag") -- auto rename html tags pairs
    -- THEMES
    use { "catppuccin/nvim", as = "catppuccin" }
    use('vim-airline/vim-airline')
    use 'nvim-tree/nvim-web-devicons'
end)
