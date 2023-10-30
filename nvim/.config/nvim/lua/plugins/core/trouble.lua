local trouble_prefix = "<leader>t"

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { trouble_prefix .. "t", "<cmd>TroubleToggle<cr>",                      desc = "TroubleToggle" },
    { trouble_prefix .. "d", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "TroubleToggle" },
    { trouble_prefix .. "w", "<cmd>TroubleToggle workspace_diagnostics<cr", desc = "TroubleToggle" },
    { trouble_prefix .. "q", "<cmd>TroubleToggle quickfix",                 desc = "TroubleToggle" },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
