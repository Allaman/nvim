return {
  "numToStr/Navigator.nvim",
  opts = {},
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    dofile(vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-a8bf42123d81/editor/nvim.lua"))
  end,
  keys = {
    { "<C-h>", "<cmd>lua require('Navigator').left()<CR>" },
    { "<C-k>", "<cmd>lua require('Navigator').up()<CR>" },
    { "<C-l>", "<cmd>lua require('Navigator').right()<CR>" },
    { "<C-j>", "<cmd>lua require('Navigator').down()<CR>" },
  },
}
