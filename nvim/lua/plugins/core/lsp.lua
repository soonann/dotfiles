return {
  -- flutter
  { 'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      local flutter = require("flutter-tools")
      flutter.setup {
        lsp = { on_attach = on_attach
        }
      }
    end
  },

  -- java language support
  { 'mfussenegger/nvim-jdtls' },

  -- golang language support
  { 'fatih/vim-go' },

  -- terraform language support
  { 'hashivim/vim-terraform' },

  -- markdown preview support
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
}
