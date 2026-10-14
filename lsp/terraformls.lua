return {
  cmd = {
    "/Users/michael/.vscode/extensions/hashicorp.terraform-2.40.0-darwin-arm64/bin/terraform-ls",
    "serve",
  },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
  capabilities = {
    experimental = {
      showReferencesCommandId = "client.showReferences",
    },
  },
  on_attach = function(_, bufnr)
    vim.lsp.codelens.enable(true, { bufnr = bufnr })
  end,
}
