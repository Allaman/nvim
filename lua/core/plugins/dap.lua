local M = {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
      { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      "theHamsta/nvim-dap-virtual-text",
    },
  },
}

return M
