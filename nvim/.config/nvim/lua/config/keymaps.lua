-- OPTIMISED KEYSTROKES HERE ------------------------------------------------------

-- map delete word in insert mode
vim.keymap.set("i", "<C-H>", "<C-w>")

-- unbind Q
vim.keymap.set("n", "Q", "<nop>")

-- remap ctrl c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- keep cursor at front of line after flushing bottom line up
vim.keymap.set("n", "J", "mzJ`z")

-- break after cursor to next line
vim.keymap.set("n", "H", "a<CR><Esc>")

-- center screen when using * and #
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- center screen when using ctrl+d and ctrl+u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- REMAPS OR ADDITIONAL MAPPINGS ------------------------------------------------------

-- remap leader q to exit file
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

-- keep whatever is copied in its buffer by deleting the highted text into the void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- shift highlighted lines down in visual mode with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- enable you to yank into system clip board so you can paste in windows
-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- bind next error and center screen
vim.keymap.set("n", "<C-k>", ":cnext<CR>zz")
vim.keymap.set("n", "<C-j>", ":cprev<CR>zz")
vim.keymap.set("n", "<leader>k", ":lnext<CR>zz")
vim.keymap.set("n", "<leader>j", ":lprev<CR>zz")

-- jump to a new tmux session
vim.keymap.set("n", "<leader>tf", ":silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- netrw open side panel
--vim.keymap.set("n", "<C-n>", ":Lexplore<CR>")

-- buffers
--vim.keymap.set("n", "<C-l>", ":bnext<CR>")
--vim.keymap.set("n", "<C-h>", ":bprev<CR>")
vim.keymap.set("n", "<leader>fx", ":bdelete!<CR>")

-- diagnostics
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>fo', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>fl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
