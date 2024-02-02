local conf = vim.g.config.plugins.chatgpt
return {
  "jackMort/ChatGPT.nvim",
  enabled = conf.enable,
  cmd = "ChatGPT",
  opts = conf.opts,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
