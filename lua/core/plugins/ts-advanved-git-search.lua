local user_config = vim.g.config.plugins.ts_advanced_git_search or {}

local default_config = {
  enabled = true,
  keys = {
    { "<leader>ga", "<cmd>Telescope advanced_git_search show_custom_functions<cr>", desc = "Advanced Git Search" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "aaronhallaert/ts-advanced-git-search.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    -- to show diff splits and open commits in browser
    "tpope/vim-fugitive",
  },
  config = function()
    require("telescope").load_extension("advanced_git_search")
  end,
  cmd = "AdvancedGitSearch",
  keys = config.keys,
}
