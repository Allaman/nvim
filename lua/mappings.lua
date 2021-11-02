local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- map the leader key
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "

-- center search results
map("n", "n", "nzz", default_options)
map("n", "N", "Nzz", default_options)

-- Deal with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- better indenting
map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", "\"_dP", default_options)

-- Tab switch buffer
map("n", "<TAB>", ":bnext<CR>", default_options)
map("n", "<S-TAB>", ":bprevious<CR>", default_options)

-- Change behaviour of Y similar to C and D
map("n", "Y", "y$", default_options)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_options)
map("n", "<Right>", ":vertical resize -1<CR>", default_options)
map("n", "<Up>", ":resize -1<CR>", default_options)
map("n", "<Down>", ":resize +1<CR>", default_options)

-- Autocorrect spelling from previous error
map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", default_options)
map("x", "J", ":move '>+1<CR>gv-gv", default_options)

-- starlite mappings
map("n", "*", "<cmd>lua require'starlite'.star()<CR>", default_options)
map("n", "g*", "<cmd>lua require'starlite'.g_star()<CR>", default_options)
map("n", "#", "<cmd>lua require'starlite'.hash()<CR>", default_options)
map("n", "g#", "<cmd>lua require'starlite'.g_hash()<CR>", default_options)

local wk = require("which-key")

-- register non leader based mappings
wk.register({ga = {"<Plug>(EasyAlign)", "Align", mode = "x"}})

-- Register all leader based mappings
wk.register({
    ["<Tab>"] = {"<cmd>e#<cr>", "Switch to previously opened buffer"},
    b = {
        name = "Buffers",
        b = {
            "<cmd>lua require'telescope.builtin'.buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
            "Find buffer"
        },
        d = {"<cmd>Bdelete!<CR>", "Close Buffer"},
        f = {"<cmd>BufferLinePick<cr>", "Pick buffer"},
        l = {"<cmd>BufferLineCloseLeft<cr>", "close all buffers to the left"},
        p = {"<cmd>BufferLineMovePrev<cr>", "Move buffer prev"},
        n = {"<cmd>BufferLineMoveNext<cr>", "Move buffer next"},
        r = {
            "<cmd>BufferLineCloseRight<cr>",
            "close all BufferLines to the right"
        },
        x = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "sort BufferLines automatically by directory"
        },
        L = {
            "<cmd>BufferLineSortByExtension<cr>",
            "sort BufferLines automatically by extension"
        }
    },
    f = {
        name = "Files",
        s = {"<cmd>w<cr>", "Save Buffer"},
        f = {
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'fd', '--hidden', '--type', 'file', '--follow'}})<cr>",
            "Find File"
        },
        l = {"<cmd>Lf<cr>", "Open LF"},
        p = {"<cmd>NvimTreeToggle<cr>", "Toogle Tree"},
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        T = {"<cmd>NvimTreeFindFile<CR>", "Find in Tree"}
    },
    g = {
        name = "Git",
        j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
        k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
        p = {"<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
        r = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
        R = {"<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
        s = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
        t = "Open Gitui", -- comand in toggleterm.lua
        n = {"<cmd>Neogit<cr>", "Open Neogit"},
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk"
        },
        g = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        B = {"<cmd>GitBlameToggle<cr>", "Toogle Blame"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)"
        }
    },
    j = {
        name = "jump",
        c = {"<cmd>lua require'hop'.hint_char2()<cr>", "2 Chars"},
        l = {"<cmd>lua require'hop'.hint_lines()<cr>", "Lines"},
        w = {"<cmd>lua require'hop'.hint_words()<cr>", "Words"}
    },
    l = {
        name = "LSP",
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
        d = {
            "<cmd>Telescope lsp_document_diagnostics<cr>",
            "Document Diagnostics"
        },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics"
        },
        -- f = { "<cmd>silent FormatWrite<cr>", "Format" },
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        j = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic"},
        k = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic"},
        q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix"},
        r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols"
        }
    },
    m = {
        name = "Misc",
        t = {"<cmd>FloatermNew --autoclose=2<cr>", "New Floaterm"},
        s = {"<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline"}
    },
    s = {
        name = "Search",
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        t = {"<cmd>Telescope live_grep<cr>", "Text"},
        s = {"<cmd>Telescope grep_string<cr>", "Text under cursor"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
        C = {"<cmd>Telescope commands<cr>", "Commands"},
        p = {"<cmd>Telescope projects<cr>", "Projects"},
        P = {
            "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview"
        }
    },
    t = {
        name = "Trouble",
        w = {
            "<cmd>Trouble lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics"
        },
        d = {"<cmd>Trouble lsp_document_diagnostics<cr>", "Document Diagnostic"},
        l = {"<cmd>Trouble loclist<cr>", "Loclist"},
        q = {"<cmd>Trouble quickfix<cr>", "Quickfix"},
        t = {"<cmd>TodoTrouble<cr>", "Todos"},
        r = {"<cmd>Trouble lsp_references<cr>", "LSP References"}
    },
    w = {
        name = "Window",
        q = {"<cmd>:q<cr>", "Close"},
        s = {"<cmd>:split<cr>", "Horizontal Split"},
        t = {"<c-w>t", "Move to new tab"},
        ["="] = {"<c-w>=", "Equally size"},
        v = {"<cmd>:vsplit<cr>", "Verstical Split"},
        w = {"<c-w>x", "Swap"}
    },
    x = {
        name = "LanguageTool",
        c = {"<cmd>GrammarousCheck<cr>", "Grammar check"},
        i = {"<Plug>(grammarous-open-info-window)", "Open the info window"},
        r = {"<Plug>(grammarous-reset)", "Reset the current check"},
        f = {"<Plug>(grammarous-fixit)", "Fix the error under the cursor"},
        x = {
            "<Plug>(grammarous-close-info-window)",
            "Close the information window"
        },
        e = {
            "<Plug>(grammarous-remove-error)",
            "Remove the error under the cursor"
        },
        n = {
            "<Plug>(grammarous-move-to-next-error)",
            "Move cursor to the next error"
        },
        p = {
            "<Plug>(grammarous-move-to-previous-error)",
            "Move cursor to the previous error"
        },
        d = {
            "<Plug>(grammarous-disable-rule)",
            "Disable the grammar rule under the cursor"
        }
    },
    z = {
        name = "Spelling",
        n = {"]s", "Next"},
        p = {"[s", "Previous"},
        a = {"zg", "Add word"},
        f = {"1z=", "Use 1. correction"},
        l = {"<cmd>Telescope spell_suggest<cr>", "List corrections"}
    }
}, {prefix = "<leader>", mode = "n", default_options})
