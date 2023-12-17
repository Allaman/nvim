return {
  "ThePrimeagen/harpoon",
  enabled = vim.g.config.plugins.harpoon.enable,
  dependencies = { "nvim-lua/plenary.nvim" },
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    vim.g.config.plugins.harpoon.key_mappings(harpoon)
  end,
}
