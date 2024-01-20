return {
  "stevearc/overseer.nvim",
  enabled = vim.g.config.plugins.overseer.enable,
  keys = {
    { "<leader>r", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
    { "<leader>tr", "<cmd>OverseerToggle<cr>", desc = "Overseer" },
  },
  opts = {},
  config = true,
}
