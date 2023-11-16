local M = {
  "ahmedkhalf/project.nvim",
  -- can't use 'opts' because module has non standard name 'project_nvim'
  config = function()
    require("project_nvim").setup({
      -- neo-tree integration
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      patterns = {
        ".git",
        "package.json",
        ".terraform",
        "go.mod",
        "requirements.yml",
        "pyrightconfig.json",
        "pyproject.toml",
      },
      -- detection_methods = { "lsp", "pattern" },
      detection_methods = { "pattern" },
    })
  end,
}

return M
