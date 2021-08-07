local map = vim.api.nvim_set_keymap

-- map the leader key
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " " -- 'vim.g' sets global variables

options = { noremap = true, silent = true }
-- center search results
map('n', 'n', 'nzz', options)
map('n', 'N', 'Nzz', options)

-- better indenting
map("v", "<", "<gv", options)
map("v", ">", ">gv", options)

-- paste over currently selected text without yanking it
map('v', 'p', '"_dP', options)

-- Tab switch buffer
map("n", "<TAB>", ":bnext<CR>", options)
map("n", "<S-TAB>", ":bprevious<CR>", options)

-- Change behaviour of Y similar to C and D
map("n", "Y", "y$", options)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", options)

-- previously opened buffer
map("n", "<Leader><TAB>", ":e#<CR>", options)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", options)
map("n", "<Right>", ":vertical resize -1<CR>", options)
map("n", "<Up>", ":resize -1<CR>", options)
map("n", "<Down>", ":resize +1<CR>", options)

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", options)
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", options)

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-j>", ":m .+1<CR>==", options)
map("n", "<A-k>", ":m .-2<CR>==", options)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", options)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", options)
map("x", "<A-j>", ":m '>+1<CR>gv-gv", options)
map("x", "<A-k>", ":m '<-2<CR>gv-gv", options)

-- bufdelete Mappings
map("n", "<Leader>x", ":Bdelete<CR>", options)
