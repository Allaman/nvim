local gh = require("config.util").gh

vim.pack.add({ gh("yousefhadder/markdown-plus.nvim") })

require("markdown-plus").setup({})
