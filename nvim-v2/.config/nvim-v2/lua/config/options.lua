local vimopt = vim.opt
local sp = 4

-- enable line numbers and relative line numbers
vimopt.nu = true
vimopt.relativenumber = true

vimopt.expandtab = true  -- expand tabs new to spaces (retab if needed)
vimopt.tabstop = sp      -- how many space = 1 tab
vimopt.softtabstop = sp  -- break tabstop down further

vimopt.autoindent = true -- auto indent next line when using o/O or enter
vimopt.shiftwidth = sp   -- no of spaces for auto indent next line

-- color column
vimopt.colorcolumn = "80";
