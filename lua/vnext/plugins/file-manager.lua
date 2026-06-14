return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<cmd>Oil --float<cr>", desc = "Open Oil" },
    },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      float = {
        max_width = 0.75,
        max_height = 0.75,
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["H"] = { "actions.toggle_hidden", mode = "n" },
      },
    },
  },

  {
    "mikavilpas/yazi.nvim",
    lazy = true,
    keys = {
      {
        "<leader>lf",
        "<cmd>Yazi<cr>",
        desc = "Open Yazi (file manager)",
      },
    },
    opts = {
      keymaps = {
        show_help = "g?",
      },
    },
  },
}
