require("mini.surround").setup({
  -- Number of lines within which surrounding is searched
  n_lines = 50,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = "sa", -- Add surrounding
    delete = "sd", -- Delete surrounding
    find = "sf", -- Find surrounding (to the right)
    find_left = "sF", -- Find surrounding (to the left)
    highlight = "sh", -- Highlight surrounding
    replace = "sr", -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
  },
})

require("mini.comment").setup({})
require("mini.jump").setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    forward = "f",
    backward = "F",
    forward_till = "t",
    backward_till = "T",
    repeat_jump = ";",
  },

  -- Delay values (in ms) for different functionalities. Set any of them to
  -- a very big number (like 10^7) to virtually disable.
  delay = {
    -- Delay between jump and highlighting all possible jumps
    highlight = 250,

    -- Delay between jump and automatic stop if idle (no jump is done)
    idle_stop = 10000000,
  },
})
require("mini.jump2d").setup({
  -- Function producing jump spots (byte indexed) for a particular line.
  -- For more information see |MiniJump2d.start|.
  -- If `nil` (default) - use |MiniJump2d.default_spotter|
  spotter = nil,
  -- Characters used for labels of jump spots (in supplied order)
  labels = "abcdefghijklmnopqrstuvwxyz",
  -- Which lines are used for computing spots
  allowed_lines = {
    blank = true, -- Blank line (not sent to spotter even if `true`)
    cursor_before = true, -- Lines before cursor line
    cursor_at = false, -- Cursor line
    cursor_after = true, -- Lines after cursor line
    fold = true, -- Start of fold (not sent to spotter even if `true`)
  },
  -- Which windows from current tabpage are used for visible lines
  allowed_windows = {
    current = true,
    not_current = true,
  },
  -- Functions to be executed at certain events
  hooks = {
    before_start = nil, -- Before jump start
    after_jump = nil, -- After jump was actually done
  },
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start_jumping = "",
  },
})

require("mini.statusline").setup({
  -- Content of statusline as functions which return statusline string. See
  -- `:h statusline` and code of default contents (used instead of `nil`).
  content = {
    -- Content for active window
    active = function()
      -- local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 30 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      return MiniStatusline.combine_groups({
        -- { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end,
    -- Content for inactive window(s)
    inactive = nil,
  },

  -- Whether to use icons by default
  use_icons = true,

  -- Whether to set Vim's settings for statusline (make it always shown with
  -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
  -- this to `false` and 'laststatus' to 3.
  set_vim_settings = false,
})

require("mini.align").setup()
