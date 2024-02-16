vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>RR",
  "<cmd>lua require('spectre.actions').run_replace()<cr>",
  { desc = "Replace all" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Rc",
  "<cmd>lua require('spectre.actions').run_current_replace()<cr>",
  { desc = "Replace current" }
)
