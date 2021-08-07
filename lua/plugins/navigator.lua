local map = vim.api.nvim_set_keymap
-- tmux navigation
map('n', "<C-h>", "<cmd>lua require('Navigator').left()<CR>", options)
map('n', "<C-k>", "<cmd>lua require('Navigator').up()<CR>", options)
map('n', "<C-l>", "<cmd>lua require('Navigator').right()<CR>", options)
map('n', "<C-j>", "<cmd>lua require('Navigator').down()<CR>", options)

