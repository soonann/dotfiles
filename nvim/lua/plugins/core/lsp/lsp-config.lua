vim.diagnostic.config({
  virtual_text = false,
}) -- disable inline errors

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",

    -- mason
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    local bufopts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      bufopts.buffer = bufnr

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

      -- formatting
      vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.keymap.set('v', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    -- used to enable autocompletion (assign to every lsp server config)
    --local capabilities = cmp_nvim_lsp.default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- servers to install and configure with mason
    local mason_servers = {
      -- lua
      lua_ls = {
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },

      -- golang
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        }
      },

      -- html
      html = {
        filetypes = {
          'html',
          'twig',
          'hbs'
        },
      },

      -- c
      clangd = {},

      -- rust
      rust_analyzer = {},

      -- nix
      rnix = {},

      -- terraform
      terraformls = {
        command = "terraform-ls serve",
      },

      -- tsserver = {},
    }

    -- enable mason and setup all servers with mason_lspconfig
    mason.setup({})
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(mason_servers),
    }
    mason_lspconfig.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = mason_servers[server_name],
          filetypes = (mason_servers[server_name] or {}).filetypes,
        }
      end
    }

    -- IMPORTANT: setup the custom lspconfigs after mason_lspconfig

    -- python lsp
    lspconfig["pylsp"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
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
      },
    })

    --  Use :FormatOnSaveToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('FormatOnSaveToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Tsserver usually works poorly. Sorry you work with bad languages
        -- You can remove this line if you know what you're doing :)
        if client.name == 'tsserver' then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
}
