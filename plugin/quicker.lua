local gh = require("config.util").gh

vim.pack.add({ gh("stevearc/quicker.nvim") })

require("quicker").setup({
  constrain_cursor = false,
})
