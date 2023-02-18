-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- File navigation plugins
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('theprimeagen/harpoon')
    -- use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

    -- Git/Versioning related plugins
    use('tpope/vim-fugitive')
    use('mbbill/undotree')
    use('airblade/vim-gitgutter')

    -- Misc/Utilities related plugins
    use('scrooloose/nerdcommenter')
    use('tpope/vim-surround')
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- Language server
    --use { 'neoclide/coc.nvim', branch = 'release' }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    -- sticky headers for functions
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    -- Other Tools
    use { 'iamcco/markdown-preview.nvim' }
    

    -- Themes
    use { "catppuccin/nvim", as = "catppuccin" }
    use('vim-airline/vim-airline')
    use 'nvim-tree/nvim-web-devicons'
end)
