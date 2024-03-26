return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    -- lazy = true,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    -- lazy = true,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",                   -- Java
          "html",                       -- HTML
          "cssls",                      -- CSS
          "lua_ls",                     -- Lua
          "bashls",                     -- Bash
          "dockerls",                   -- Docker
          "docker_compose_language_service", -- Docker Compose
          "pyright",                    -- Python
          "jsonls",                     -- Json
          "yamlls",                     -- YAML
          "clangd",                     -- C++
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    ft = { "lua", "python", "sh", "c", "cpp", "arduino", "html", "css" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier", -- ts/js formatter
          "stylua",  -- lua formatter
          "eslint_d", -- ts/js linter
          "clang-format", -- C formater
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
    ft = { "lua", "python", "sh", "c", "cpp", "arduino", "html", "css" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "[g", ":Lspsaga diagnostic_jump_prev<cr>", { desc = "Go to prev LSP diagnoctic" })
      vim.keymap.set("n", "]g", ":Lspsaga diagnostic_jump_prev<cr>", { desc = "Go to next LSP diagnostic" })

      -- There is may be function for dooing stuff with LSP
      local on_attach = nil

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Do LSP trought whhich-key
          local wk = require("which-key")
          local mappings = {
            l = {
              name = "LSP things",
              d = { ":Lspsaga goto_definition<cr>", "Goto defenition" },
              D = { ":Lspsaga goto_type_definition<cr>", "Goto type defenition" },
              k = { ":Lspsaga hover_doc<cr>", "Hover" },
              o = { ":Lspsaga outline<cr>", "List functions" },
              a = { ":Lspsaga code_action<cr>", "Code action" },
              r = { ":Lspsaga rename<cr>", "Rename" },
              R = { ":Lspsaga finder<cr>", "Reference" },
            },
          }
          local optss = { prefix = "<leader>" }

          wk.register(mappings, optss)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature" }, opts)
          vim.keymap.set(
            "n",
            "<leader>lf",
            vim.lsp.buf.add_workspace_folder,
            { desc = "Add workspace folder" },
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>lF",
            vim.lsp.buf.remove_workspace_folder,
            { desc = "Remove workspace folder" },
            opts
          )
          vim.keymap.set("n", "<leader>ll", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "List workspace folder" }, opts)
        end,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "! ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- local capabilities = lspconfig.capabilities()
      -- enable keybinds only for when lsp server available
      -- configure  arduino server
      lspconfig["arduino_language_server"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "arduino-language-server",

          "-cli-config",
          "/home/igrik/.arduino15/arduino-cli.yaml",
          "-fqbn",
          "esp32:esp32:esp32",
          "-cli",
          "/usr/bin/arduino-cli",
          "-clangd",
          "/usr/bin/clangd",
        },
      })

      -- configure clangd server
      lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        server_capabilities = {
          signatureHelpProvider = {
            false,
          },
        },
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      })

      -- configure html server
      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure typescript server with plugin
      -- typescript.setup({
      --   server = {
      --     capabilities = capabilities,
      --     on_attach = on_attach,
      --   },
      -- })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure lua server (with special settings)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
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
      })

      -- configure Bash
      lspconfig["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure Pyright
      lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 300,
        },
        settings = {
          python = {
            analysis = {
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
              inlayHints = {
                functionReturnTypes = true,
              },
            },
          },
          pyright = {},
        },
      })
    end,
  },
}
