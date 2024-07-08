return {
  "supermaven-inc/supermaven-nvim",
  enabled = vim.g.config.plugins.supermaven.enable,
  dependencies = "hrsh7th/nvim-cmp",
  config = function()
    -- TODO: fix if someone cares
    -- local utils = require("utils.functions")
    -- local api = require("supermaven-nvim.api")
    -- utils.map("n", "<leader>msm", api.start(), { desc = "Enable Supermaven" })
    require("supermaven-nvim").setup({
      disable_inline_completion = true, -- disables inline completion for use with cmp
      -- disable_keymaps = true -- disables built in keymaps for more manual control
    })
  end,
}
