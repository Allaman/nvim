local user_config = vim.g.config.plugins.ts_advanced_git_search or {}

local default_config = {
  enabled = true,
  opts = {},
  keys = {
    { "<leader>ga", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced Git Search" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "aaronhallaert/ts-advanced-git-search.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "tpope/vim-fugitive",
  },
  cmd = "AdvancedGitSearch",
  keys = config.keys,
  opts = config.opts,
  config = function(_, opts)
    require("advanced_git_search.fzf").setup({ opts })
  end,
}
