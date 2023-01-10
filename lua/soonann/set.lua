-- fatcursor 
vim.opt.guicursor = ""

-- enable line numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space tab 
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- disable line wraps
vim.opt.wrap = false

-- disable swap files backups and enable undo file for undotree plugin 
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- disable highlighting for search but enable incremental search
-- incremental search highlights the terms as you type your regex expression
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- enable syntax highlighting
vim.opt.termguicolors = true

-- end of page always has 8 spaces available on the bottom except end of file
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- netrw 
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- disable mouse 
vim.opt.mouse = ""
