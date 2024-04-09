local user_config = vim.g.config.plugins.harpoon or {}

local default_config = {
  enabled = false,
  opts = {},
  keys = {
    -- stylua: ignore start
    { "<leader>a", function() require("harpoon"):list():append() end, desc = "Harpoon append", },
    { "<leader>0", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon UI", },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 2", },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2", },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3", },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4", },
    -- stylua: ignore end
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "ThePrimeagen/harpoon",
  enabled = config.enabled,
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  branch = "harpoon2",
  keys = config.keys,
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
  end,
}
