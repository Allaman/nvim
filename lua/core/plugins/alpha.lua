local M = {
  "goolord/alpha-nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
}

function M.config()
  require("core.plugins.alpha.alpha")
end

return M
