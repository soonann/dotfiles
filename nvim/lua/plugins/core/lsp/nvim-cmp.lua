return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",            -- on insert mode
  dependencies = {
    "hrsh7th/cmp-buffer",           -- text in buffer
    "hrsh7th/cmp-path",             -- file system paths
    "L3MON4D3/LuaSnip",             -- snippet
    "saadparwaiz1/cmp_luasnip",     -- snippet
    "rafamadriz/friendly-snippets", -- snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect"
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.InsertEnter,
          select = true,
        },
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
      }),
    })
  end
}
