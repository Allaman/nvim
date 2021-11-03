local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.load_extension('projects')

telescope.setup{
  defaults = {
    file_ignore_patterns = {"node_modules", "%.jpg", "%.png"},
    vimgrep_arguments = {
      'rg',
      '--follow',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    mappings = {
      i = {
        -- Close on first esc instead of gonig to normal mode
        ["<esc>"] = actions.close,
        ["<A-q>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
      },
      n = {
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<A-q>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
      },
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
      horizontal = { mirror = false },
      vertical = { mirror = true },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    -- path_display = true, -- strange behaviour not showing the files in result window
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
