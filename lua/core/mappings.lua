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

-- switch buffer
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("core.utils.functions").escapePair()
end)

-- search like you are used to
map("n", "<C-f>", "/", { desc = "Search buffer" })

-- save like your are used to
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- toggles
map("n", "<leader>th", function()
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })
map("n", "<leader>tl", function()
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle sgincolumn" })
map("n", "<leader>tv", function()
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })
map("n", "<leader>ts", function()
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell" })
map("n", "<leader>tw", function()
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })
map("n", "<leader>tc", function()
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })
map(
  "n",
  "<leader>to",
  "<cmd>lua require('core.utils.functions').toggle_colorcolumn()<cr>",
  { desc = "Toggle colorcolumn" }
)
map(
  "n",
  "<leader>tt",
  "<cmd>lua require('core.plugins.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
map("n", "<leader>ts", "<cmd>SymbolsOutline<cr>", { desc = "Toggle SymbolsOutline" })

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
    f = { "<cmd>" .. require("core.utils.functions").project_files() .. "<cr>", "Find File" },
    p = { "<cmd>Neotree reveal toggle<cr>", "Toggle Filetree" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save Buffer" },
    z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  },
  m = {
    name = "Misc",
    C = { "<cmd>:CBcatalog<cr>", "Commentbox Catalog" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    p = { "<cmd>Lazy check<cr>", "Lazy check" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
    k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
    q = { "<cmd>lua require('core.utils.functions').toggle_qf()<cr>", "Toggle quickfix list" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  t = { name = "Toggles" },
  -- hydra heads
  s = { "Search" },
  w = { "Windows" },
  z = { "Spelling" },
}, { prefix = "<leader>", mode = "n", default_options })
