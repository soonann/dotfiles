return {

  { 'Issafalcon/lsp-overloads.nvim' },

  -- copilot
  -- { 'github/copilot.vim' },

  -- Flutter
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true
  },

  -- Java language support
  -- { 'mfussenegger/nvim-jdtls' },
  {
    'nvim-java/nvim-java',
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      }
    },
  },

  -- Golang language support - nvimcmp autocomplete not working :(
  --{ 'fatih/vim-go' },

  -- Terraform language support
  { 'hashivim/vim-terraform' },

  -- Android language support
  --{ "hsanson/vim-android" },

  -- Kotlin language support
  --{ "udalov/kotlin-vim", },

  -- Markdown preview support
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "mrjosh/helm-ls",
  },

  --{
  --"stevearcc/vim-arduino",
  --},
}
