  require("project_nvim").setup {
    patterns = { ".git", "Makefile", "package.json", ".terraform", "go.mod" },
  }
  vim.g.nvim_tree_update_cwd = 1
  vim.g.nvim_tree_respect_buf_cwd = 1
