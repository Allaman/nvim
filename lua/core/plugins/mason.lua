local settings = require("core.settings")

local M = {
  "williamboman/mason.nvim",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", module = "mason" },
  },
  config = function()
    -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
    require("mason").setup()

    -- ensure tools (except LSPs) are installed
    local mr = require("mason-registry")
    for _, tool in ipairs(settings.tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    -- install LSPs
    require("mason-lspconfig").setup({ ensure_installed = settings.lsp_servers })
  end,
}

return M
