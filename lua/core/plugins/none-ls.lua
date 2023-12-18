local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- enabled = false,
  config = function()
    require("core.plugins.lsp.none-ls")
  end,
}

return M
