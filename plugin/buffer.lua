local gh = require("config.util").gh

vim.pack.add({ gh("akinsho/bufferline.nvim") })

require("bufferline").setup({
  options = {
    show_buffer_close_icons = false,
    always_show_bufferline = false,
  },
})

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", {
  desc = "Next buffer",
})

vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", {
  desc = "Previous buffer",
})
