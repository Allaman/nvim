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
        file_ignore_patterns = {"node_modules", "%.jpg", "%.png"},
        vimgrep_arguments = {
            "rg", "--follow", "--color=never", "--no-heading",
            "--with-filename", "--line-number", "--column", "--smart-case"
        },
        mappings = {
            i = {
                -- Close on first esc instead of gonig to normal mode
                ["<esc>"] = actions.close,
                ["<A-q>"] = actions.send_selected_to_qflist,
                ["<C-q>"] = actions.send_to_qflist,
                ["<s-tab>"] = actions.toggle_selection
                    + actions.move_selection_next,
                ["<tab>"] = actions.toggle_selection
                    + actions.move_selection_previous,
                ["<cr>"] = custom_actions.multi_selection_open,
                ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
                ["<c-s>"] = custom_actions.multi_selection_open_split,
                ["<c-t>"] = custom_actions.multi_selection_open_tab
            },
            n = {
                ["<s-tab>"] = actions.toggle_selection
                    + actions.move_selection_next,
                ["<tab>"] = actions.toggle_selection
                    + actions.move_selection_previous,
                ["<A-q>"] = actions.send_selected_to_qflist,
                ["<C-q>"] = actions.send_to_qflist,
                ["<cr>"] = custom_actions.multi_selection_open,
                ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
                ["<c-s>"] = custom_actions.multi_selection_open_split,
                ["<c-t>"] = custom_actions.multi_selection_open_tab
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
