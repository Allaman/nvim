local M = {
  "ahmedkhalf/project.nvim",
}

function M.config()
  require("project_nvim").setup({
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
end

return M
