-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Themes
    use { "catppuccin/nvim", as = "catppuccin" }
    use('vim-airline/vim-airline')

    -- File navigation plugins
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('theprimeagen/harpoon')
    use 'nvim-tree/nvim-web-devicons'
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
    use 'voldikss/vim-floaterm'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }


    -- Git/Versioning related plugins
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

    ---- Language server
    use { 'neoclide/coc.nvim', branch = 'release' }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/nvim-treesitter-context'

end)
