local utils = require("utils.functions")
local map = vim.keymap.set

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- window
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
map("n", "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Move window to new tab" })
map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
map("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
map("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
map("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
map("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
map("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
map("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
map("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
map("n", "<leader>wl", "<cmd>vertical resizce -3<cr>", { desc = "Right" })

-- buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Previously openend Buffer" })

-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("utils.functions").escapePair()
end)

-- save like your are used to
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
-- save file
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
-- open path under cursor
map("n", "<leader>fo", "gf", { desc = "Open path under cursor" })

-- search and replace is a pain with a German keyboard layout
map({ "n" }, "<leader>sr", ":%s/", { desc = "Buffer search and replace" })

-- toggles
map("n", "<leader>th", function()
  utils.notify("Toggling hidden chars", vim.log.levels.INFO, "core.mappings")
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })
map("n", "<leader>tm", function()
  utils.notify("Toggling signcolumn", vim.log.levels.INFO, "core.mappings")
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })
map("n", "<leader>tv", function()
  utils.notify("Toggling virtualedit", vim.log.levels.INFO, "core.mappings")
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })
map("n", "<leader>tO", "<cmd>lua require('utils.functions').toggle_colorcolumn()<cr>", { desc = "Toggle colorcolumn" })
map(
  "n",
  "<leader>tt",
  "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
map("n", "<leader>tS", "<cmd>windo set scb!<cr>", { desc = "Toggle Scrollbind" })

-- Spelling
map("n", "<leader>zl", "<cmd>FzfLua spell_suggest<cr>", { desc = "List corrections" })
map("n", "<leader>zf", "1z=", { desc = "Use first correction" })
map("n", "<leader>zj", "]s", { desc = "Next error" })
map("n", "<leader>zk", "[s", { desc = "Previous error" })
map("n", "<leader>za", "zg", { desc = "Add word" })

-- Reload snippets folder
-- TODO make path system independent
map("n", "<leader>ms", "<cmd>source ~/.config/nvim/snippets/*<cr>", { desc = "Reload snippets" })
