return {
  "nvim-pack/nvim-spectre",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local wk = require("which-key")
    wk.register({
      R = { "Replace" },
    }, { prefix = "<leader>", mode = "n", {} })
  end,
  enabled = vim.g.config.plugins.spectre.enable,
  keys = {
    {
      "<leader>Rr",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle search and replace",
    },
    {
      "<leader>Rw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search current word",
    },
    {
      "<leader>Rw",
      mode = "v",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search current word",
    },
    {
      "<leader>Rf",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Search in current file",
    },
    {
      "<leader>Rc",
      function()
        require("spectre.actions").run_current_replace()
      end,
      desc = "Replace current",
    },
    {
      "<leader>RR",
      function()
        require("spectre.actions").run_replace()
      end,
      desc = "Replace all",
    },
  },
}
