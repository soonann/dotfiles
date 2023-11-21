return {

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
  { 'mfussenegger/nvim-jdtls' },

  -- Golang language support - nvimcmp autocomplete not working :(
  --{ 'fatih/vim-go' },

  -- Terraform language support
  { 'hashivim/vim-terraform' },

  -- Android language support
  { "hsanson/vim-android" },

  -- Markdown preview support
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "hsanson/vim-android",
  },
}
