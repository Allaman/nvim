local map = vim.api.nvim_set_keymap
map('n', '<C-p>', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'fd', '--hidden', '--type', 'file', '--follow'}})<cr>", options)
map('n', '<Leader>fr', '<cmd>Telescope oldfiles<cr>', options) -- last opened files
map('n', '<Leader>rg', '<cmd>Telescope live_grep<cr>', options) -- search for a string in current working directory
map('n', '<Leader>b', '<cmd>Telescope buffers<cr>', options) -- list buffers
map('n', '<Leader>/', '<cmd>Telescope grep_string<cr>', options) -- search string under cursor in working directory
map('n', '<Leader>t', '<cmd>Telescope<cr>', options) -- search string under cursor in working directory

local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup{
  defaults = {
    file_ignore_patterns = {"node_modules", "%.jpg"},
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
      }
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
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
