local user_config = vim.g.config.plugins.substitute or {}

local default_config = {
  enabled = false,
  keys = {
    -- stylua: ignore start
    { "s", function() require("substitute").operator() end, desc = "Substitute", },
    { "s", mode = "x", function() require("substitute").visual() end, desc = "Substitute", },
    -- stylua: ignore end
  },
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "gbprod/substitute.nvim",
  enabled = config.enabled,
  keys = config.keys,
  opts = config.opts,
}
