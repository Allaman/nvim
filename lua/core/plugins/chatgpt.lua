local config = vim.g.config.plugins.chatgpt
return {
  "jackMort/ChatGPT.nvim",
  enabled = config.enable,
  cmd = { "ChatGPT", "ChatGPTRun" },
  opts = config.opts,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
