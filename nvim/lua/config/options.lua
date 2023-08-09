-- fatcursor
--vim.opt.guicursor = ""

-- enable line numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space tab
spaces = 2
vim.opt.tabstop = spaces
vim.opt.softtabstop = spaces
vim.opt.shiftwidth = spaces
vim.opt.expandtab = true
vim.opt.smartindent = true

-- disable line wraps - enabled because I like it :)
--vim.opt.wrap = false

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
vim.g.netrw_keepdir = 0

vim.g.netrw_rmf_cmd = "mv /tmp/"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- disable mouse
vim.opt.mouse = ""

vim.opt.clipboard = "unnamedplus"

-- if vim.fn.has("wsl") == 1 then
--     vim.g.clipboard = {
--         name = "win32yank-wsl",
--         copy = {
--             ["+"] = "win32yank.exe -i --crlf",
--             ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--             ["+"] = "win32yank.exe -o --lf",
--             ["*"] = "win32yank.exe -o --lf",
--         },
--         cache_enabled = 0,
--     }
-- end
--
--
