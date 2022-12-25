local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  x = {
    name = "LanguageTool",
    c = { "<cmd>GrammarousCheck<cr>", "Grammar check" },
    i = { "<Plug>(grammarous-open-info-window)", "Open the info window" },
    r = { "<Plug>(grammarous-reset)", "Reset the current check" },
    f = { "<Plug>(grammarous-fixit)", "Fix the error under the cursor" },
    x = {
      "<Plug>(grammarous-close-info-window)",
      "Close the information window",
    },
    e = {
      "<Plug>(grammarous-remove-error)",
      "Remove the error under the cursor",
    },
    j = {
      "<Plug>(grammarous-move-to-next-error)",
      "Move cursor to the next error",
    },
    k = {
      "<Plug>(grammarous-move-to-previous-error)",
      "Move cursor to the previous error",
    },
    d = {
      "<Plug>(grammarous-disable-rule)",
      "Disable the grammar rule under the cursor",
    },
  },
}, { prefix = "<leader>", mode = "n", default_options })
