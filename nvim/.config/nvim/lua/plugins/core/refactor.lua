return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local refactoring = require("refactoring")
    refactoring.setup()

    vim.keymap.set("x", "<leader>re", function() refactoring.refactor('Extract Function') end)
    vim.keymap.set("x", "<leader>rf", function() refactoring.refactor('Extract Function To File') end)
    -- Extract function supports only visual mode
    vim.keymap.set("x", "<leader>rv", function() refactoring.refactor('Extract Variable') end)
    -- Extract variable supports only visual mode
    vim.keymap.set("n", "<leader>rI", function() refactoring.refactor('Inline Function') end)
    -- Inline func supports only normal
    vim.keymap.set({ "n", "x" }, "<leader>ri", function() refactoring.refactor('Inline Variable') end)
    -- Inline var supports both normal and visual mode

    vim.keymap.set("n", "<leader>rb", function() refactoring.refactor('Extract Block') end)
    vim.keymap.set("n", "<leader>rbf", function() refactoring.refactor('Extract Block To File') end)
    -- Extract block supports only normal mode

    -- prompt for a refactor to apply when the remap is triggered
    vim.keymap.set(
      { "n", "x" },
      "<leader>rr",
      function() refactoring.select_refactor() end
    )

    -- load refactoring Telescope extension
    local telescope = require("telescope")
    telescope.load_extension("refactoring")

    -- refactor prompt with telescope
    vim.keymap.set({ "n", "x" }, "<leader>rr", function() telescope.extensions.refactoring.refactors() end)
  end,
}
