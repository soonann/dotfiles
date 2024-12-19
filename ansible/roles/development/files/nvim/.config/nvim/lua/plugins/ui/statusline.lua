return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_b = {
          {
            function()
              local key = require("grapple").key()
              return "  [" .. key .. "]"
            end,
            cond = require("grapple").exists,
          }
        }
      }
    })
  end
}
