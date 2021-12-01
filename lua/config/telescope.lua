local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local custom_actions = {}
local telescope = require("telescope")

telescope.load_extension("projects")

function custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = #picker:get_multi_selection()
    if num_selections > 1 then
        local cwd = picker.cwd
        if cwd == nil then
            cwd = ""
        else
            cwd = string.format("%s/", cwd)
        end
        vim.cmd("bw!") -- wipe the prompt buffer
        for _, entry in ipairs(picker:get_multi_selection()) do
            vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
        end
        vim.cmd("stopinsert")
    else
        if open_cmd == "vsplit" then
            actions.file_vsplit(prompt_bufnr)
        elseif open_cmd == "split" then
            actions.file_split(prompt_bufnr)
        elseif open_cmd == "tabe" then
            actions.file_tab(prompt_bufnr)
        else
            actions.file_edit(prompt_bufnr)
        end
    end
end
function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "edit")
end

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
        file_sorter = require"telescope.sorters".get_fuzzy_file,
        generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
        -- path_display = true, -- strange behaviour not showing the files in result window
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require"telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require"telescope.previewers".buffer_previewer_maker
    }
}
