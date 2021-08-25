local g = vim.g
require("project_nvim").setup {
  patterns = { ".git", "Makefile", "package.json", ".terraform", "go.mod", "requirements.yml" },
  -- detection_methods = { "lsp", "pattern" },
  detection_methods = { "pattern" },
}
g.nvim_tree_update_cwd = 1
g.nvim_tree_respect_buf_cwd = 1
