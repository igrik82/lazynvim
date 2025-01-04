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
			-- Функция проверки архитектуры для установки cpptools
			local packet = function()
				local handle = io.popen("uname -m", "r")
				if handle then
					local arch = handle:read("*a")
					handle:close()
					-- Delete all unnesary symbols
					arch = arch:gsub("\n", "")
					if arch == "aarch64" then
						return
					else
						-- Перечислить нужные пакеты здесь в фроматее
						-- return "cpptools", "beautysh"
						return "clangd"
					end
				end
			end
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- "tsserver",                   -- Java
					"html", -- HTML
					"cssls", -- CSS
					"lua_ls", -- Lua
					"bashls", -- Bash
					"dockerls", -- Docker
					"docker_compose_language_service", -- Docker Compose
					"pyright", -- Python
					"jsonls", -- Json
					"yamlls", -- YAML
					packet(),
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
					"stylua", -- lua formatter
					"eslint_d", -- ts/js linter
					"clang-format", -- C formater
					"shfmt", -- Shell formatter
					"shellcheck", -- Shell linter
				},
				-- auto-install configured formatters & linters (with null-ls)
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "InsertEnter",
		ft = { "lua", "python", "sh", "c", "cpp", "arduino", "html", "css", "ino" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "[g", ":Lspsaga diagnostic_jump_prev<cr>", { desc = "Go to prev LSP diagnoctic" })
			vim.keymap.set("n", "]g", ":Lspsaga diagnostic_jump_prev<cr>", { desc = "Go to next LSP diagnostic" })

			-- configure format on save
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local on_attach, _ =
				function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								local save_wiev = vim.fn.winsaveview()
								vim.lsp.buf.format({
									-- filter = function(client)
									-- 	--  only use null-ls for formatting instead of lsp server
									-- 	return client.name == "null-ls"
									-- end,
									bufnr = bufnr,
									-- async = true,
								})
								vim.fn.winrestview(save_wiev)
							end,
						})
					end
				end, vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("UserLspConfig", {}),
					callback = function(ev)
						-- Do LSP trought whhich-key
						local wk = require("which-key")
						wk.add({
							{ "<leader>l", group = "LSP things" },
							{ "<leader>lD", ":Lspsaga goto_type_definition<cr>", desc = "Goto type defenition" },
							{ "<leader>lR", ":Lspsaga finder<cr>", desc = "Reference" },
							{ "<leader>la", ":Lspsaga code_action<cr>", desc = "Code action" },
							{ "<leader>ld", ":=vim.lsp.buf.definition()<cr>", desc = "Goto defenition" },
							{ "<leader>lk", ":Lspsaga hover_doc<cr>", desc = "Hover" },
							{ "<leader>lo", ":Lspsaga outline<cr>", desc = "List functions" },
							{ "<leader>lr", ":Lspsaga rename<cr>", desc = "Rename" },
						})

						-- Enable completion triggered by <c-x><c-o>
						vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
						-- Buffer local mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local opts = { buffer = ev.buf }
						vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature" }, opts)
						vim.keymap.set("n", "<leader>lf", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" }, opts)
						vim.keymap.set("n", "<leader>lF", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" }, opts)
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
					"-clangd",
					"/usr/bin/clangd",
					"-cli",
					"/usr/bin/arduino-cli",
					"-cli-config",
					"/home/igrik/.arduino15/arduino-cli.yaml",
					"-fqbn",
					"arduino:esp32:esp32",
				},
				-- filetypes = { "ino", "arduino" },
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
					"--background-index",
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
