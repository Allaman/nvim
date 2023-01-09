local settings = require("core.settings")

local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({})

    -- TODO: https://github.com/Allaman/nvim/issues/37
    require("mason-lspconfig").setup({})

    require("mason-tool-installer").setup({
      ensure_installed = settings.mason_tool_installer_ensure_installed,
    })
  end,
}

return M
