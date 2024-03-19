return {
  {
    "williamboman/mason.nvim",
    -- lazy =true,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
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
    config = function()
      local lspconfig = require("lspconfig")

      -- enable keybinds only for when lsp server available
      local on_attach = function(client, bufnr) end
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
      lspconfig["lua_ls"].setup({
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
