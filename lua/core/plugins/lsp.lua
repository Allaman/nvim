local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
  },
  config = function()
    require("core.plugins.lsp.lsp")
  end,
}

return M
