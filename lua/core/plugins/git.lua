local utils = require("core.utils")
M = {}

M.packages = {
  {
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        cmd = {
          "DiffviewOpen",
          "DiffviewClose",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
        },
        config = utils.get_config("git.diffview"),
      },
    },
    module = "neogit",
    config = utils.get_config("git.neogit"),
  },
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = utils.get_config("git.gitsigns"),
  },
  { "tpope/vim-fugitive" }, -- yeah this is not lua but one of the best Vim plugins ever
}

return M
