-- only for TodoQuickFix, highlighting is done by mini.hipatterns
local M = {
  "folke/todo-comments.nvim",
  keys = {
    { "<leader>qt", "<cmd>TodoQuickFix<cr>", desc = "Show TODOs" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

return M
