-- prefix
local trouble_prefix = "<leader>t"

-- disable inline errors
vim.diagnostic.config({
  virtual_text = false,
})


return {
  -- LSP Zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.api.nvim_command, 'MasonUpdate')
        end,
      },                                       -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero').preset({})
      local cmp = require("cmp")
      local luasnip = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
          ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
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
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
      })

      lsp.on_attach(function(client, bufnr)
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        -- goto navigations
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)

        -- code actions
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

        -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#enable-format-on-save
        vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
        vim.keymap.set('v', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
      end)

      lsp.ensure_installed({
        'lua_ls',
        'rust_analyzer',
        'clangd',
      })

      lsp.setup()

      -- custom lsp after lsp setup
      local lsp_configurations = require('lspconfig.configs')
      if not lsp_configurations.terraform_lsp then
        lsp_configurations.terraform_lsp = {
          default_config = {
            name = 'terraform-lsp',
            cmd = { 'terraform-lsp' },
            filetypes = { '*.tf', '*.autovars' },
            root_dir = require('lspconfig.util').root_pattern('.terraform', '.git')
          }
        }
      end
      require('lspconfig').terraform_lsp.setup({})

      local vimgo = require("vim-go")
      vimgo.setup({})

      require('lspconfig').pylsp.setup {
        settings = {
          pylsp = {
            plugins = {
              autopep8 = {
                enabled = false
              },
              flake8 = {
                enabled = true
              },
            }
          }
        }
      }


      -- enable format on save
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#enable-format-on-save
      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
          ['terraformls'] = { 'terraform', 'terraform-vars' },
          ['clangd'] = { 'c' },
          ['pylsp'] = { 'python' },
        }
      })
    end
  },

  -- Flutter
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true
  },

  -- Java language support
  { 'mfussenegger/nvim-jdtls' },

  -- Golang language support
  { 'fatih/vim-go' },

  -- Terraform language support
  { 'hashivim/vim-terraform' },

  -- Markdown preview support
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Errors
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { trouble_prefix .. "t", "<cmd>TroubleToggle<cr>",                      desc = "TroubleToggle" },
      { trouble_prefix .. "d", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "TroubleToggle" },
      { trouble_prefix .. "w", "<cmd>TroubleToggle workspace_diagnostics<cr", desc = "TroubleToggle" },
      { trouble_prefix .. "q", "<cmd>TroubleToggle quickfix",                 desc = "TroubleToggle" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }

}
