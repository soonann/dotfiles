local grapple = require('grapple')

grapple.setup({
    ---@type "debug" | "info" | "warn" | "error"
    log_level = "warn",

    ---Can be either the name of a builtin scope resolver,
    ---or a custom scope resolver
    ---@type string | Grapple.ScopeResolver
    scope = "git",

    ---Window options used for the popup menu
    popup_options = {
        relative = "editor",
        width = 60,
        height = 12,
        style = "minimal",
        focusable = false,
        border = "single",
    },

    integrations = {
        ---Support for saving tag state using resession.nvim
        resession = false,
    },
})

vim.keymap.set("n", "<leader>e",":GrapplePopup tags<CR>")
vim.keymap.set("n", "<leader>a", grapple.toggle)
vim.keymap.set("n", "<leader>1", function() grapple.select({key=1})  end)
vim.keymap.set("n", "<leader>2", function() grapple.select({key=2})  end)
vim.keymap.set("n", "<leader>3", function() grapple.select({key=3})  end)
vim.keymap.set("n", "<leader>4", function() grapple.select({key=4})  end)
vim.keymap.set("n", "<leader>5", function() grapple.select({key=5})  end)

