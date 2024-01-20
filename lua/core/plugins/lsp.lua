local conf = vim.g.config

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "folke/neoconf.nvim", config = true, ft = "lua" }, -- must be loaded before lsp
    },
    config = function()
      require("core.plugins.lsp.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", module = "mason" },
    },
    config = function()
      -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
      require("mason").setup()

      -- ensure tools (except LSPs) are installed
      local mr = require("mason-registry")
      local function install_ensured()
        for _, tool in ipairs(conf.tools) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_ensured)
      else
        install_ensured()
      end

      -- install LSPs
      require("mason-lspconfig").setup({ ensure_installed = conf.lsp_servers })
    end,
  },
}
