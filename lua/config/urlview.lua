local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  m = {
    u = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy URL" },
  },
}, { prefix = "<leader>", mode = "n", default_options })
