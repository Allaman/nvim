return {
  "stevearc/overseer.nvim",
  enabled = vim.g.config.plugins.overseer.enable,
  keys = {
    { "<leader>r", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
    { "<leader>tr", "<cmd>OverseerToggle<cr>", desc = "Overseer" },
  },
  opts = {
    task_list = {
      bindings = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
      },
    },
  },
  config = true,
}
