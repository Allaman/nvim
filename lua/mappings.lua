local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

--Remap space as leader key
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- better indenting
map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", '"_dp', default_options)
map("v", "P", '"_dP', default_options)

-- Tab switch buffer
map("n", "<tab>", ":bnext<CR>", default_options)
map("n", "<S-tab>", ":bprev<CR>", default_options)

-- Cancel search highlighting with ESC
map("n", "<esc>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Autocorrect spelling from previous error
map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_options)
map("x", "J", ":move '>+1<CR>gv-gv", default_options)

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("utils").escapePair()
end, default_options)

local wk = require("which-key")

-- register non leader based mappings
wk.register({
  sa = "Add surrounding",
  sd = "Delete surrounding",
  sh = "Highlight surrounding",
  sn = "Surround update n lines",
  sr = "Replace surrounding",
  sF = "Find left surrounding",
  sf = "Replace right surrounding",
  ss = { "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>", "Jump to character" },
  st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
})

-- Register leader based mappings
wk.register({
  ["<tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
  b = {
    name = "Buffers",
    b = {
      "<cmd>Telescope buffers<cr>",
      "Find buffer",
    },
    D = {
      "<cmd>%bd|e#|bd#<cr>",
      "Close all but the current buffer",
    },
    d = { "<cmd>Bdelete<cr>", "Close buffer" },
  },
  f = {
    name = "Files",
    b = { "<cmd>Telescope file_browser grouped=true<cr>", "File browser" },
    f = { "<cmd>" .. require("utils").telescope_find_files() .. "<cr>", "Find File" },
    p = { "<cmd>Neotree reveal toggle<cr>", "Toggle Filetree" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save Buffer" },
    z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  },
  m = {
    name = "Misc",
    c = { "<cmd>lua require('utils').toggle_colorcolumn()<cr>", "Toggle Colorcolumn" },
    C = { "<cmd>:CBcatalog<cr>", "Commentbox Catalog" },
    d = { "<cmd>lua require('config.lsp.utils').toggle_diagnostics()<cr>", "Toggle Diagnostics" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    o = { "Options" },
    p = { "<cmd>PackerSync --preview<cr>", "PackerSync" },
    s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
    k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
    q = { "<cmd>lua require('utils').toggle_qf()<cr>", "Toggle quickfix list" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  -- hydra heads
  s = { "Search" },
  w = { "Windows" },
  z = { "Spelling" },
}, { prefix = "<leader>", mode = "n", default_options })
