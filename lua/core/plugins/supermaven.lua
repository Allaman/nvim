-- https://github.com/supermaven-inc/supermaven-nvim
local user_config = vim.g.config.plugins.supermaven or {}

local default_config = {
  enabled = false,
  autostart = false,
  opts = {
    disable_inline_completion = true, -- disables inline completion for use with cmp
  },
  keys = {
    { "<leader>mC", "<cmd>SupermavenToggle<cr>", desc = "Toggle Supermaven" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "supermaven-inc/supermaven-nvim",
  enabled = config.enabled,
  event = "InsertEnter",
  dependencies = "hrsh7th/nvim-cmp",
  opts = config.opts,
  keys = config.keys,
  config = function(_, opts)
    require("supermaven-nvim").setup(opts)
    local api = require("supermaven-nvim.api")
    if not config.autostart then
      if api.is_running() then
        api.stop()
        return
      end
    end
  end,
}
