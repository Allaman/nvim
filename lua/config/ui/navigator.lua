require("Navigator").setup()
local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
-- tmux navigation
map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", default_options)
map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", default_options)
map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", default_options)
map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", default_options)
