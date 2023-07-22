return {
  'mbbill/undotree', -- undo to specific changes
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end 
}

