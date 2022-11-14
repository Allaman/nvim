local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  c = {
    name = "Coding",
    r = { "<cmd>source %<cr>", "Run buffer" },
  },
}, { prefix = "<leader>", mode = "n", default_options })
