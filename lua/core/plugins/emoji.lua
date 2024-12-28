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

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(ctx, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },
    },
  },
}
