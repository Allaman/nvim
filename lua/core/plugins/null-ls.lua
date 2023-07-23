-- TODO: DEPRECATED https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
-- https://github.com/mattn/efm-langserver
-- https://github.com/tsuyoshicho/vim-efm-langserver-settings/blob/28b5535ca731233ee6e88bab2102610600c2b615/config/efm-langserver/config.yaml
local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("core.plugins.lsp.null-ls")
  end,
}

return M
