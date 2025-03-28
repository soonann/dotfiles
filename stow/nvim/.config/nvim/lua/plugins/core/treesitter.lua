return {

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = { "TSUpdateSync" },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ignore_install = { "help" },
                -- A list of parser names, or "all"
                ensure_installed = {
                    "vim",
                    "vimdoc",
                    "lua",

                    -- "awk",
                    "bash",

                    "c",
                    -- "css",

                    "diff",
                    "dockerfile",

                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",

                    "go",
                    "gomod",
                    "gosum",
                    -- "graphql",

                    "hcl",
                    -- "html",

                    -- "java",
                    -- "javascript",
                    -- "jsdoc",
                    "json",

                    "latex",

                    "markdown",
                    "markdown_inline",
                    "make",

                    "python",

                    "rust",

                    "sql",
                    -- "starlark",

                    "terraform",

                    "yaml",

                    "zig",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = true,
                },
            })
        end,
    },

    -- sticky headers
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            enable = true
        end,
    },

}
