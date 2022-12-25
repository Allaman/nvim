local utils = require("core.utils")
local M = {}

M.packages = {
  { "neovim/nvim-lspconfig", config = utils.get_config("lsp.lsp") },
  { "onsails/lspkind-nvim" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = utils.get_config("lsp.null-ls"),
  },
  { "SmiteshP/nvim-navic" },
  {
    "williamboman/mason.nvim",
    cmd = "Mason*",
    module = "mason-tool-installer",
    requires = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
    config = utils.get_config("lsp.mason"),
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
    before = "nvim-lspconfig",
  },
}

return M
