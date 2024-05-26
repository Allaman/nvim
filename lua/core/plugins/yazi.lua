local user_config = vim.g.config.plugins.yazi or {}
local utils = require("utils.functions")

local default_config = {
  enabled = false,
  keys = {
    -- TODO: my mapping <leader>lf is soo good but in the LSP cluster
    {
      "<leader>lf",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open Yazi (file manager)",
    },
  },
  opts = {
    open_for_directories = true,
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "mikavilpas/yazi.nvim",
  enabled = utils.isNeovimVersionsatisfied(10) and config.enabled,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = config.keys,
  opts = config.opts,
}
