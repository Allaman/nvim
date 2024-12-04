local user_config = vim.g.config.plugins.spectre or {}

local default_config = {
  enabled = false,
  keys = {
    { "<leader>R", "", desc = "Search & Replace" },
    {
      "<leader>Rr",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle search and replace",
    },
    {
      "<leader>Rw",
      mode = { "v", "n" },
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search word",
    },
    {
      "<leader>Rf",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Search in current file",
    },
  },
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = config.enabled,
  keys = config.keys,
  opts = config.opts,
}
