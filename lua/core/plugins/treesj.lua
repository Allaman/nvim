return {
  "Wansmer/treesj",
  keys = {
    { "<leader>mSt", "<cmd>TSJToggle<cr>", desc = "Toggle" },
    { "<leader>mSj", "<cmd>TSJJoin<cr>", desc = "Join" },
    { "<leader>mSs", "<cmd>TSJSplit<cr>", desc = "Split" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
  config = true,
}
