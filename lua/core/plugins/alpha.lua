return {
  "goolord/alpha-nvim",
  init = false,
  enabled = function()
    local utils = require("utils.functions")
    local db = utils.safe_nested_config(vim.g.config, "dashboard")
    if db == "dashboard" then
      return false
    end
    return true -- alpha is the default dashboard
  end,
  event = "VimEnter",
  dependencies = {
    "famiu/bufdelete.nvim", -- for autocmd
  },
  config = function()
    require("utils.functions").dashboard_autocmd(":Alpha | bd#")
    require("core.plugins.alpha.alpha")
  end,
}
