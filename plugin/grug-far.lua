local gh = require("config.util").gh

vim.pack.add({ gh("MagicDuck/grug-far.nvim") })

local grug = require("grug-far")

grug.setup({})

vim.keymap.set("n", "<leader>rr", "<cmd>GrugFar<cr>", {
  desc = "Open",
})

vim.keymap.set("n", "<leader>rR", function()
  grug.open({
    prefills = {
      paths = vim.fn.expand("%"),
    },
  })
end, {
  desc = "Open (Limit to current file)",
})

vim.keymap.set("n", "<leader>rw", function()
  grug.open({
    prefills = {
      search = vim.fn.expand("<cword>"),
    },
  })
end, {
  desc = "Search word under cursor",
})

vim.keymap.set("v", "<leader>rs", function()
  grug.with_visual_selection({
    prefills = {
      paths = vim.fn.expand("%"),
    },
  })
end, {
  desc = "Search selection",
})
