local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.diagnostics.eslint,
		nls.builtins.formatting.prettier.with({
			extra_args = { "--single-quote", "false" },
		}),
		nls.builtins.formatting.terraform_fmt,
		nls.builtins.formatting.black,
		nls.builtins.formatting.goimports,
		nls.builtins.formatting.gofumpt,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- NOTE: on < 0.8, you should use vim.lsp.buf.formatting_sync() instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
