local util = require("config.util")

vim.g.tmux_navigator_no_mappings = 1

util.pack("numToStr/Navigator.nvim")

local navigator = require("Navigator")

-- config = function()
--   dofile(vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-a8bf42123d81/editor/nvim.lua"))
-- end,

navigator.setup({})

vim.keymap.set("n", "<C-h>", navigator.left, {
  desc = "Navigate left",
})

vim.keymap.set("n", "<C-k>", navigator.up, {
  desc = "Navigate up",
})

vim.keymap.set("n", "<C-l>", navigator.right, {
  desc = "Navigate right",
})

vim.keymap.set("n", "<C-j>", navigator.down, {
  desc = "Navigate down",
})
