require('vscode').setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,


})

function ColorMyPencils(color)

    color = color or "vscode"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "normalfloat", { bg = "none"})

end

ColorMyPencils()
