local actions = require("telescope.actions")
local custom_actions = {}
local telescope = require("telescope")

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("heading")
telescope.load_extension "file_browser"

telescope.setup {
    defaults = {
        file_ignore_patterns = {"node_modules", ".terraform", "%.jpg", "%.png"},
        vimgrep_arguments = {
            "rg", "--follow", "--color=never", "--no-heading",
            "--with-filename", "--line-number", "--column", "--smart-case"
        },
        mappings = {
            i = {
                -- Close on first esc instead of gonig to normal mode
                -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<C-k>"] = actions.move_selection_previous,
                ["<A-q>"] = actions.send_selected_to_qflist,
                ["<C-q>"] = actions.send_to_qflist,
                ["<Tab>"] = actions.toggle_selection
                    + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection
                    + actions.move_selection_better,
                ["<cr>"] = actions.select_default,
                ["<c-v>"] = actions.select_vertical,
                ["<c-s>"] = actions.select_horizontal,
                ["<c-t>"] = actions.select_tab
            }
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "flex",
        layout_config = {
            width = 0.75,
            prompt_position = "bottom",
            preview_cutoff = 120,
            horizontal = {mirror = false},
            vertical = {mirror = true}
        },
        file_sorter = require"telescope.sorters".get_fzf_sorter,
        generic_sorter = require"telescope.sorters".get_fzf_sorter,
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"} -- default = nil,
    }
}
