local mocha = require("catppuccin.palettes").get_palette "mocha"
vim.opt.termguicolors = true


require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
    options = {
        indicator = {
            style = "underline"
        },
        close_command = ":bp|sp|bn|bd",
        right_mouse_command = ":bp|sp|bn|bd",
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                highlight = "Directory",
                text_align = "left"
            },
        },

    }
}
