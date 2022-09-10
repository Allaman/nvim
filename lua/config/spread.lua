local spread = require("spread")
local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  m = {
    S = {
      name = "Spread",
      c = { spread.combine, "Combine" },
      s = { spread.out, "Split" },
    },
  },
}, { prefix = "<leader>", mode = "n", default_options })
