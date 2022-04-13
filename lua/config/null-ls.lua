local nls = require("null-ls")
nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.diagnostics.eslint,
		nls.builtins.completion.spell,
		nls.builtins.diagnostics.golangci_lint,
		nls.builtins.formatting.prettier.with({
			extra_args = { "--single-quote", "false" },
		}),
		nls.builtins.formatting.terraform_fmt,
		nls.builtins.formatting.black,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			-- auto format on save (not asynchronous)
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
