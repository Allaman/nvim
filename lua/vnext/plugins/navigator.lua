return {
  "numToStr/Navigator.nvim",
  event = "VeryLazy",
  config = function()
    require("Navigator").setup({})
    local map = vim.api.nvim_set_keymap
    -- tmux navigation
    map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", {})
    map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", {})
    map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", {})
    map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", {})
  end,
}
