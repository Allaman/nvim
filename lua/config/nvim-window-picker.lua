require("window-picker").setup({
  autoselect_one = true,
  include_current = false,
  selection_chars = "fjdkslacmrueiwoqp",
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = {
        "neo-tree",
        "neo-tree-popup",
        "notify",
        "packer",
        "qf",
        "diff",
        "fugitive",
        "fugitiveblame",
      },

      -- if the buffer type is one of following, the window will be ignored
      buftype = { "nofile", "help", "terminal" },
    },
  },
  -- other_win_hl_color = "#e35e4f",
})
