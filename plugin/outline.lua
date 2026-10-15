local util = require("config.util")

util.pack("hedyhli/outline.nvim")

require("outline").setup({
  symbol_folding = {
    autofold_depth = 1,
  },

  guides = {
    enabled = false,
  },
})

vim.keymap.set("n", "<leader>to", "<cmd>Outline<cr>", {
  desc = "Toggle Outline",
})
