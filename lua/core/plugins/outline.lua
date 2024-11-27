local user_config = vim.g.config.plugins.outline or {}

local default_config = {
  keys = {
    { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  opts = {
    symbol_folding = {
      -- Depth past which nodes will be folded by default
      autofold_depth = 1,
    },
    guides = {
      enabled = false,
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  opts = config.opts,
  keys = config.keys,
}
