local M = {
  "ironhouzi/starlite-nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local map = vim.keymap.set
    map({ "n", "x" }, "*", function()
      require("starlite").star()
    end, { desc = "Search forward (word)" })
    map({ "n", "x" }, "g*", function()
      require("starlite").g_star()
    end, { desc = "Search forward" })
    map({ "n", "x" }, "#", function()
      require("starlite").hash()
    end, { desc = "Search backward (word)" })
    map({ "n", "x" }, "g#", function()
      require("starlite").g_hash()
    end, { desc = "Search backward" })
  end,
}

return M
