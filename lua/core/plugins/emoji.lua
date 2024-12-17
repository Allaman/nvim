local user_config = vim.g.config.plugins.emoji or {}

local default_config = {
  enabled = false,
  opts = {},
}
local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "allaman/emoji.nvim",
    ft = "markdown",
    dependencies = "hrsh7th/nvim-cmp",
    opts = config.opts,
    dev = true,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "emoji" },
        providers = { emoji = { kind = "text" } },
      },
    },
  },
}
