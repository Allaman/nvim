local M = {
  "allaman/kustomize.nvim",
  ft = "yaml",
}

function M.config()
  require("kustomize").setup({ defaults = true })
end

return M
