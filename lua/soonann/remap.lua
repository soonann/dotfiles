vim.g.mapleader = " "

-- OPTIMISED KEYSTROKES HERE --------------------------------------------------------

-- unbind Q
vim.keymap.set("n", "Q", "<nop>")

-- remap ctrl c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- keep cursor at front of line after flushing bottom line up
vim.keymap.set("n", "J", "mzJ`z")

-- center screen when using ctrl+d and ctrl+u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- REMAPS OR ADDITIONAL MAPPINGS ------------------------------------------------------

-- remap leader pv to exit file
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)
--vim.keymap.set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- keep whatever is copied in its buffer by deleting the highted text into the void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- shift highlighted lines down in visual mode with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- enable you to yank into system clip board so you can paste in windows
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- bind next error and center screen
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- jump to a new tmux session
vim.keymap.set("n", "<leader>tf", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- netrw open side panel
vim.keymap.set("n", "<C-n>", ":Lexplore<cr>")

-- buffers
vim.keymap.set("n", "<C-l>", ":bnext<cr>")
vim.keymap.set("n", "<C-h>", ":bprev<cr>")
vim.keymap.set("n", "<C-x>", ":bdelete!<cr>")
