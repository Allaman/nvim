local nls = require("null-ls")
nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.diagnostics.eslint,
		nls.builtins.completion.spell,
		nls.builtins.formatting.prettier.with({
			extra_args = { "--single-quote", "false" },
		}),
		nls.builtins.formatting.terraform_fmt,
		nls.builtins.formatting.black,
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			-- auto format on save (not asynchronous)
			local LspFormattingGrp = vim.api.nvim_create_augroup("LspFormattingGrp", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				command = "lua vim.lsp.buf.format()",
				group = LspFormattingGrp,
			})
		end
	end,
})
