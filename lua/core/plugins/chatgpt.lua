local config = vim.g.config.plugins.chatgpt
return {
  "jackMort/ChatGPT.nvim",
  enabled = config.enable,
  cmd = { "ChatGPT", "ChatGPTRun" },
  opts = config.opts,
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
