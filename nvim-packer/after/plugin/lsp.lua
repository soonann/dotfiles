local lsp = require("lsp-zero")
local cmp = require("cmp")
local luasnip = require('luasnip')
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<space>fo', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>fl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)

-- on attach function
local on_attach = function(client)
    require("lsp-format").on_attach(client)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- goto navigations
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)

    -- code actions
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('v', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end


require("flutter-tools").setup {
    lsp = {
        on_attach = on_attach
    }
}

-- nvim cmp opts
local nvim_cmp_opts = {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs( -4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
}

lsp.preset("recommended")
lsp.ensure_installed({})

lsp.setup_nvim_cmp(nvim_cmp_opts)
lsp.on_attach(on_attach)

--vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--pattern = { "*.tf", "*.tfvars" },
--callback = function(ev)
--vim.lsp.buf.format()
--end
--})

lsp.setup()
