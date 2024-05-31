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

      -- client exists
      if client then
        -- Check if the server supports formatting
        if client.server_capabilities.documentFormattingProvider then
          -- Sync formatting prevents weird buffer interactions
          vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = false } end, bufopts)
          vim.keymap.set('v', '<leader>fm', function() vim.lsp.buf.format { async = false } end, bufopts)
        end
      end
    end

    -- used to enable autocompletion (assign to every lsp server config)
    --local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- servers to install and configure with mason
    -- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
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

      --golang
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

      -- typescript
      tsserver = {
      },

      -- svelte
      svelte = {
      },

      -- tailwind
      tailwindcss = {
      },


      -- html
      html = {
        filetypes = {
          'html',
          'twig',
          'hbs'
        },
      },

      -- nix
      rnix = {},

      -- terraform
      terraformls = {
        command = "terraform-ls serve",
      },

      bufls = {},

      -- yaml
      -- https://www.reddit.com/r/neovim/comments/ze9gbe/kubernetes_auto_completion_support_in_neovim/
      --yamlls = {
      --settings = {
      --yaml = {
      --schemas = {
      --["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
      --"*.{yml,yaml}",
      --["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
      --["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      --["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      --["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
      --["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      --["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
      --["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
      --["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
      --"*api*.{yml,yaml}",
      --["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
      --"*compose*.{yml,yaml}",
      --["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
      --"*flow*.{yml,yaml}",
      --},
      --},
      --}
      --},

      -- kotlin lsp
      kotlin_language_server = {

      },

      -- bash lsp
      bashls = {

      },

    }

    -- enable mason
    mason.setup({})
    -- setup all servers with mason_lspconfig
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(mason_servers),
      handlers = {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = mason_servers[server_name],
            filetypes = (mason_servers[server_name] or {}).filetypes,
          }
        end
      },
    }

    -- IMPORTANT: setup the custom lspconfigs after mason_lspconfig
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    lspconfig["jdtls"].setup({})

    -- python lsp
    lspconfig["pylsp"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            autopep8 = {
              enabled = true
            },
            flake8 = {
              enabled = true
            },
          }
        }
      },
    })

    -- rust_analyzer lsp
    lspconfig['rust_analyzer'].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true,
          }
        }
      }
    })

    lspconfig["clangd"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "clangd", "--completion-style=detailed" },
    })

    -- arduino lsp
    lspconfig["arduino_language_server"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "arduino-lsp-wrapper"
      },
    })


    lspconfig.helm_ls.setup {
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
          }
        }
      }
    }

    -- tiltfile
    lspconfig['tilt_ls'].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- ========== Other formatting/lsp related functions ==================

    -- tiltfile set filetype
    vim.api.nvim_create_autocmd('BufRead', {
      pattern = "*Tiltfile",
      group = vim.api.nvim_create_augroup('Tiltfile', { clear = true }),
      callback = function(args)
        vim.api.nvim_command('setf tiltfile')
        vim.api.nvim_command('setlocal commentstring=#\\ %s')
        vim.treesitter.start(args.buf, 'starlark')
      end
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

        -- ignore tsserver and gopls for formatting
        if client.name == 'tsserver'  then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            -- check if format_on_save is enabled
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

        -- instead of gopls, use this for formatting
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({ async = false })
          end
        })
      end,
    })
  end,
}
