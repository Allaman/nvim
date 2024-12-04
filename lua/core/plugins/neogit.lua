local user_config = vim.g.config.plugins.neogit or {}

local default_config = {
  enabled = true,
  keys = {
    { "<leader>g<Enter>", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
  opts = {
    process_spinner = false,
    graph_style = "kitty",
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  enabled = config.enabled,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = config.keys,
  opts = config.opts,
}
