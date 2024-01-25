-- fatcursor
--vim.opt.guicursor = ""

-- enable line numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

spaces = 2
vim.opt.expandtab = true     -- expand tabs new to spaces (retab if needed)
vim.opt.tabstop = spaces     -- how many space = 1 tab
vim.opt.softtabstop = spaces -- break tabstop down further

vim.opt.autoindent = true    -- auto indent next line when using o/O or enter
vim.opt.shiftwidth = spaces  -- no of spaces for auto indent next line

-- fix hash removing indents: https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
-- smartindent is deprecated for cindent
-- vim.opt.smartindent = true   -- auto indent next line for lang specific e.g c


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
-- vim.opt.inccommand = "split"

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

vim.g.omni_sql_no_default_maps = 1

--vim.opt.clipboard = "unnamedplus"

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
