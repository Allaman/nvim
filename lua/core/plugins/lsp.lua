local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
  },
}

function M.config()
  require("core.plugins.lsp.lsp")
end

return M
