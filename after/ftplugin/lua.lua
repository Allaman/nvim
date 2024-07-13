local wk = require("which-key")
wk.add({
  { "<leader>c", "", desc = "+Coding" },
  {
    "<leader>cr",
    function()
      require("luapad.run").run()
    end,
    desc = "Run buffer content",
  },
  {
    "<leader>cl",
    function()
      require("luapad").init()
    end,
    desc = "Luapad",
  },
  { "<leader>ct", "<cmd>lua MiniTest.run_file()<cr>", desc = "MiniTest for current file" },
  { "<leader>cs", "<cmd>lua MiniTest.run()<cr>", desc = "Run MiniTest suite" },
})
