local icons = require("utils.icons")
local M = {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      breadcrumb = icons.arrows.DoubleArrowRight, -- symbol used in the command line area that shows your active key combo
      separator = icons.arrows.SmallArrowRight, -- symbol used between a key and it's label
      group = icons.ui.Plus, -- symbol prepended to a group
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 10, 3, 10 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 3, max = 25 }, -- min and max height of the columns
      width = { min = 5, max = 50 }, -- min and max width of the columns
      spacing = 10, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    groups = {
      mode = { "n", "v" },
      ["<leader>b"] = { name = "Buffers" },
      ["<leader>f"] = { name = "Files" },
      ["<leader>l"] = { name = "LSP" },
      ["<leader>m"] = { name = "Misc" },
      ["<leader>q"] = { name = "Quickfix" },
      ["<leader>R"] = { name = "Replace" },
      ["<leader>mS"] = { name = "TreeSJ" },
      ["<leader>s"] = { name = "Search" },
      ["<leader>t"] = { name = "Toggles" },
      -- Hydra not working with "name" key
      ["<leader>w"] = { "Windows" },
      ["<leader>z"] = { "Spelling" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.groups)
  end,
}

return M
