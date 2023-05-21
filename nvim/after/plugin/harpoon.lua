local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
    },
    --mark_branch = false,
    --projects = {
    --},
    --global_settings = {
    --save_on_toggle = false,
    --mark_branch = true,
    --excluded_filetypes = {
    --"harpoon"
    --},
    --enter_on_sendcmd = false,
    --save_on_change = true,
    --tmux_autoclose_windows = false
    --}
})

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

vim.keymap.set("n", "<leader>0", function() ui.nav_next() end)
vim.keymap.set("n", "<leader>9", function() ui.nav_prev() end)
