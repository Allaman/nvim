local M = {
  "simrat39/symbols-outline.nvim",
  opts = {
    -- Depth past which nodes will be folded by default
    autofold_depth = 1,
  },
  keys = {
    { "<leader>tO", "<cmd>SymbolsOutline<cr>", desc = "Toggle SymbolsOutline" },
  },
}

return M
