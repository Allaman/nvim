local map = vim.api.nvim_set_keymap
options = { noremap = true, silent = true }

-- map the leader key
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", options)
vim.g.mapleader = " " -- 'vim.g' sets global variables

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
-- captured by window manager for now
-- map("n", "<A-j>", ":m .+1<CR>==", options)
-- map("n", "<A-k>", ":m .-2<CR>==", options)
-- map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", options)
-- map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", options)
-- map("x", "<A-j>", ":m '>+1<CR>gv-gv", options)
-- map("x", "<A-k>", ":m '<-2<CR>gv-gv", options)

-- starlite mappings
map("n", "*", "<cmd>lua require'starlite'.star()<CR>", options)
map("n", "g*", "<cmd>lua require'starlite'.g_star()<CR>", options)
map("n", "#", "<cmd>lua require'starlite'.hash()<CR>", options)
map("n", "g#", "<cmd>lua require'starlite'.g_hash()<CR>", options)

local wk = require("which-key")

wk.register({
  ga = {"<Plug>(EasyAlign)", "Align", mode="x"},

})

-- Register all leader based mappings
wk.register({
  b = {
    name = "Buffers",
    p = { "<cmd>BufferLineMovePrev<cr>", "Move buffer prev"},
    n = { "<cmd>BufferLineMoveNext<cr>", "Move buffer next"},
    j = { "<cmd>BufferPick<cr>", "jump to buffer" },
    b = { "<cmd>lua require'telescope.builtin'.buffers({ sort_mru = true, ignore_current_buffer = true })<cr>", "Find buffer" },
    x = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    l = { "<cmd>BufferLineCloseLeft<cr>", "close all buffers to the left" },
    r = {
      "<cmd>BufferLineCloseRight<cr>",
      "close all BufferLines to the right",
    },
    d = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "sort BufferLines automatically by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "sort BufferLines automatically by extension",
    },
  },
  f = {
    name = "Files",
    s = { "<cmd>w<cr>", "Save Buffer" },
    f = { "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'fd', '--hidden', '--type', 'file', '--follow'}})<cr>", "Find File" },
    l = { "<cmd>Lf<cr>", "Open LF" },
    p = { "<cmd>NvimTreeToggle<cr>", "Toogle Tree"},
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    T = { "<cmd>NvimTreeFindFile<CR>", "Find in Tree" },
  },
  g = {
    name = "Git",
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    t = "Open Gitui", -- comand in toggleterm.lua
    n = { "<cmd>Neogit<cr>", "Open Neogit"},
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    g = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    B = { "<cmd>GitBlameToggle<cr>", "Toogle Blame" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
  },
  j = {
    name = "jump",
    c = {"<cmd>lua require'hop'.hint_char2()<cr>", "2 Chars"},
    l = {"<cmd>lua require'hop'.hint_lines()<cr>", "Lines"},
    w = {"<cmd>lua require'hop'.hint_words()<cr>", "Words"},
  },
  l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = {
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        "Document Diagnostics",
      },
      w = {
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        "Workspace Diagnostics",
      },
      -- f = { "<cmd>silent FormatWrite<cr>", "Format" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      j = {
        "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
    },
  m = {
    name = "Misc",
    t = {"<cmd>FloatermNew --autoclose=2<cr>", "New Floaterm"},
  },
  s = {
    name = "Search",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    y = "Symbols",
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    s = { "<cmd>Telescope grep_string<cr>", "Text under cursor" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = { "<cmd>Telescope projects<cr>", "Projects"},
    P = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
  },
  t = {
    name = "Trouble",
    w = {"<cmd>Trouble lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    d = {"<cmd>Trouble lsp_document_diagnostics<cr>", "Document Diagnostic"},
    l = {"<cmd>Trouble loclist<cr>", "Loclist"},
    q = {"<cmd>Trouble quickfix<cr>", "Quickfix"},
    t = {"<cmd>TodoTrouble<cr>", "Todos"},
    r = {"<cmd>Trouble lsp_references<cr>", "LSP References"},
  },
  x = {
    name = "LanguageTool",
    c = {"<cmd>GrammarousCheck<cr>", "Grammar check" },
    i = {"<Plug>(grammarous-open-info-window)", "Open the info window" },
    r = {"<Plug>(grammarous-reset)", "Reset the current check" },
    f = {"<Plug>(grammarous-fixit)", "Fix the error under the cursor" },
    x = {"<Plug>(grammarous-close-info-window)", "Close the information window" },
    e = {"<Plug>(grammarous-remove-error)", "Remove the error under the cursor" },
    n = {"<Plug>(grammarous-move-to-next-error)", "Move cursor to the next error" },
    p = {"<Plug>(grammarous-move-to-previous-error)", "Move cursor to the previous error" },
    d = {"<Plug>(grammarous-disable-rule)", "Disable the grammar rule under the cursor" },
  }
}, { prefix = "<leader>", mode = "n", noremap = true, silent = true })
