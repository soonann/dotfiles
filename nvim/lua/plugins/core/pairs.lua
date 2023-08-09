return {

  -- god tier brackets control
  {
    'tpope/vim-surround'
  },

  -- auto create pairs [{()}]
  {
    "windwp/nvim-autopairs",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({})
    end
  },

  -- auto rename html tags when changing one
  {
    "windwp/nvim-ts-autotag"
  },

  -- toggling multi line codes
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>J",
        "<CMD>TSJToggle<CR>",
        desc = "Toggle tree-sitter join"
      },
    },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false }
  },

}
