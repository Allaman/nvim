local settings = require("core.settings")

local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
    require("mason").setup({})

    -- TODO: https://github.com/Allaman/nvim/issues/37
    require("mason-lspconfig").setup({})

    require("mason-tool-installer").setup({
      ensure_installed = settings.mason_tool_installer_ensure_installed,
    })
  end,
}

return M
