-- disable v
-- local presets = require("which-key.plugins.presets")
-- presets.operators["v"] = nil
require("which-key").setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 2, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    "<silent>",
    "<cmd>",
    "<Cmd>",
    "<cr>",
    "<CR>",
    "call",
    "lua",
    "require",
    "^:",
    "^ ",
  }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

local wk = require("which-key")
local default_options = { silent = true }

-- register non leader based mappings
wk.register({
  ga = { "<Plug>(EasyAlign)", "Align", mode = "x" },
  sa = "Add surrounding",
  sd = "Delete surrounding",
  sh = "Highlight surrounding",
  sn = "Surround update n lines",
  sr = "Replace surrounding",
  sF = "Find left surrounding",
  sf = "Replace right surrounding",
  ss = { "<Plug>Lightspeed_s", "Search 2-character forward" },
  -- SS = {"<Plug>Lightspeed_S", "Search 2-character backward"}
  st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
})

-- Register all leader based mappings
wk.register({
  ["<Tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
  ["<leader>"] = {
    name = "Leader",
    a = { "<cmd>lua print('fasfAS')<cr>", "test" },
  },
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
    d = { "<cmd>Bdelete!<CR>", "Close buffer" },
  },
  f = {
    name = "Files",
    b = { "<cmd>Telescope file_browser<cr>", "File browser" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    l = { "<cmd>Lf<cr>", "Open LF" },
    p = { "<cmd>Neotree reveal toggle<cr>", "Toggle Filetree" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>w<cr>", "Save Buffer" },
    z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  },
  g = { "Git" },
  m = {
    name = "Misc",
    a = {
      "<cmd>lua require'telegraph'.telegraph({cmd='gitui', how='tmux_popup'})<cr>",
      "Test Telegraph",
    },
    c = { "<cmd>CheatSH<cr>", "Cht.sh" },
    C = { "<cmd>lua require('functions').toggle_colorcolumn()<cr>", "Toggle Colorcolumn" },
    d = { "<cmd>lua require('functions').toggle_diagnostics()<cr>", "Toggle Diagnostics" },
    f = { "<cmd>FocusToggle<cr>", "Toggle Focus" },
    i = { "<cmd>IlluminateToggle<cr>", "Toggle Illuminate" },
    l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
    o = { "Options" },
    p = { "<cmd>PackerSync<cr>", "PackerSync" },
    s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
    t = { "<cmd>FloatermNew --autoclose=2<cr>", "New Floaterm" },
  },
  q = {
    name = "Quickfix",
    j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
    k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
    q = { "<cmd>lua require('functions').toggle_qf()<cr>", "Toggle quickfix list" },
    t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
  },
  s = { "Search" },
  w = { "Windows" },
  x = {
    name = "LanguageTool",
    c = { "<cmd>GrammarousCheck<cr>", "Grammar check" },
    i = { "<Plug>(grammarous-open-info-window)", "Open the info window" },
    r = { "<Plug>(grammarous-reset)", "Reset the current check" },
    f = { "<Plug>(grammarous-fixit)", "Fix the error under the cursor" },
    x = {
      "<Plug>(grammarous-close-info-window)",
      "Close the information window",
    },
    e = {
      "<Plug>(grammarous-remove-error)",
      "Remove the error under the cursor",
    },
    n = {
      "<Plug>(grammarous-move-to-next-error)",
      "Move cursor to the next error",
    },
    p = {
      "<Plug>(grammarous-move-to-previous-error)",
      "Move cursor to the previous error",
    },
    d = {
      "<Plug>(grammarous-disable-rule)",
      "Disable the grammar rule under the cursor",
    },
  },
  z = {
    name = "Spelling",
    n = { "]s", "Next" },
    p = { "[s", "Previous" },
    a = { "zg", "Add word" },
    f = { "1z=", "Use 1. correction" },
    l = { "<cmd>Telescope spell_suggest<cr>", "List corrections" },
  },
}, { prefix = "<leader>", mode = "n", default_options })
