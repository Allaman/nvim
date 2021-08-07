vim.api.nvim_set_keymap('n', '<Leader>jw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<Leader>jc', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('n', '<Leader>jl', "<cmd>lua require'hop'.hint_lines()<cr>", {})
