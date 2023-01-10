local wk = require("which-key")
-- normal mode mappings 
wk.register({
    -- telescope related bindings 
    p = {
        name = "project",
        f = {
            f = { "project files find - find all project files" },
        },
        g = {
            f = { "project git find - find only git related files" },
        },
        s = { "project search - finding terms" },
    },

    -- harpoon related bindings
    a = "add - harpoon mark",
    e = "explorer - harpoon toggle menu",
    ["1"] = "1st mark - harpoon menu 1 to 5",
    ["0"] = "harpoon next menu",
    ["9"] = "harpoon prev menu",

    -- undotree bindings
    u = "undotree - show undotree",

    -- misc bindings 
    f = {
        q = "quit",
    },
    k = "next location",
    j = "prev location",
    y = "yank to system clipboard",
    r = "replace word globally in file with regex",
    n = "open netrw",

}, { prefix = "<leader>" })

-- visual mode mappings 
wk.register({
    p = "paste without overwriting current buffer",
    y = "yank to system clipboard",
}, {
    mode = "v",
    prefix = "<leader>"
})
