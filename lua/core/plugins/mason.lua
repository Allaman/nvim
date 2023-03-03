local settings = require("core.settings")

local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
    require("mason").setup({ ensure_installed = settings.tools })
    require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })

    -- TODO: https://github.com/Allaman/nvim/issues/37
    -- require("mason-lspconfig").setup({})
  end,
}

return M
