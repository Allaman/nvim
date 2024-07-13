return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = vim.g.config.plugins.spectre.enable,
    keys = {
      { "<leader>R", "", desc = "Replace" },
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
  },
}
