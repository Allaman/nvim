local gh = require("config.util").gh

vim.pack.add({ gh("gbprod/substitute.nvim") })

local substitute = require("substitute")

substitute.setup({})

-- stylua: ignore start
vim.keymap.set("n", "s", substitute.operator, {
  desc = "Substitute",
  noremap = true,
})

vim.keymap.set("x", "ss", substitute.visual, {
  desc = "Substitute",
  noremap = true,
})
-- stylua: ignore end
