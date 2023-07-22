return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function ()
    require("catppuccin").setup({
      background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    highlight_overrides = {
      mocha = function(mocha)
        return {
          LineNr = { fg = mocha.overlay1 },
        }
      end,
    },
    integrations = {
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      gitgutter = true,
    },
  })


  -- setup must be called before loading

  vim.g.airline_theme = 'catppuccin'
  vim.cmd.colorscheme "catppuccin"
  vim.api.nvim_set_hl(0, "normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })
end
}
