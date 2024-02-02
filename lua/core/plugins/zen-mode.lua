local utils = require("utils.functions")
return {
  "folke/zen-mode.nvim",
  enabled = vim.g.config.plugins.zenmode.enable,
  dependencies = {
    "folke/twilight.nvim",
  },
  keys = {
    {
      "<leader>tz",
      "<cmd>ZenMode<cr>",
      desc = "Toggle ZenMode",
    },
  },
  opts = {
    window = {
      backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      width = 0.70, -- width of the Zen window
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
      },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
      vim.opt["conceallevel"] = 3
      vim.opt["concealcursor"] = "nc"
      utils.stopLSP("ltex")
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
      vim.opt["conceallevel"] = 0
      vim.opt["concealcursor"] = ""
      utils.startLSP("ltex")
    end,
  },
}
