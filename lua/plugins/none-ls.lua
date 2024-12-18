return {
	"nvimtools/none-ls.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	ft = { "sh", "html", "json", "yaml", "markdown", "toml" },
	config = function()
		local null_ls = require("null-ls")

		local augroup = vim.api.nvim_create_augroup("NoneLs", {})
		-- for concisenessV
		local formatting = null_ls.builtins.formatting -- to setup formatters
		-- local diagnostics = null_ls.builtins.diagnostics -- to setup linters
		-- configure null_ls
		null_ls.setup({
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				formatting.prettier.with({
					filetypes = { "html", "json", "yaml", "markdown", "toml" },
				}), -- js/ts formatter
				formatting.stylua, -- lua formatter
				-- formatting.autopep8.with({
				-- 	extra_args = { "--indent-size=4", "--ignore=E402,E401" },
				-- }),
				formatting.black.with({
					extra_args = { "--line-length", "79" },
				}),
				formatting.shfmt.with({
					extra_args = { "-i", "2", "-ci" },
				}),
				-- diagnostics.pylint.with({
				-- 	diagnostics_on_save = true,
				-- 	diagnostics_format = "[#{c}] #{m} (#{s})",
				-- 	extra_args = { "-d", "C0103, C0115, C0116" },
				-- 	diagnostics_postprocess = function(diagnostic)
				-- 		diagnostic.code = diagnostic.message_id
				-- 	end,
				-- }),
				formatting.clang_format.with({
					extra_args = { "--style=WebKit" },
				}),

				-- diagnostics.flake8.with({
				-- 	-- diagnostics_on_save = true,
				-- 	diagnostics_format = "[#{c}] #{m} (#{s})",
				-- 	-- extra_args = { "-d", "C0103, C0115, C0116" },
				-- 	diagnostics_postprocess = function(diagnostic)
				-- 		diagnostic.code = diagnostic.message_id
				-- 	end,
				-- }),
			},

			-- -- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
