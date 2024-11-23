local user_config = vim.g.config.plugins.highlight_colors or {}

local default_config = {
  enabled = true,
  opts = {},
  keys = {
    {
      "<leader>mc",
      function()
        require("nvim-highlight-colors").toggle()
      end,
      desc = "Toggle highlight-colors",
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  enabled = config.enabled,
  opts = config.opts,
  keys = config.keys,
}
