local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

local wk = require("which-key")
wk.add({
  { "<leader>c", "", desc = "+Coding" },
  { "<leader>cl", "<cmd>lua print('TODO')<cr>", desc = "Todo" },
  { "<leader>cc", "<cmd>lua print('TODO')<cr>", desc = "Todo2" },
})
