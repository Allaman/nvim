local gh = require("config.util").gh

vim.pack.add({
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1"),
  },
  {
    src = gh("saghen/blink.compat"),
    version = vim.version.range("2"),
  },
})
