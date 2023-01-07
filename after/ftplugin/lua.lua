local wk = require("which-key")
local default_options = { silent = true }
wk.register({
  c = {
    name = "Coding",
    r = {
      function()
        require("luapad.run").run()
      end,
      "Run buffer content",
    },
    l = {
      function()
        require("luapad").init()
      end,
      "Luapad",
    },
    t = { "<cmd>lua MiniTest.run_file()<cr>", "MiniTest for current file" },
    s = { "<cmd>lua MiniTest.run()<cr>", "Run MiniTest suite" },
  },
}, { prefix = "<leader>", mode = "n", default_options })
