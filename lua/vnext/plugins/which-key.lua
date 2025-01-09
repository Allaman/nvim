return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 0,
    height = math.huge,
    icons = {
      mappings = false, -- disable icons in keymaps
    },
    sort = { "alphanum" },
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "Diagnostic" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Code" },
      { "<leader>m", group = "Misc" },
      -- { "<leader>q", group = "Quickfix" },
      { "<leader>R", group = "Replace" },
      -- { "<leader>mS", group = "TreeSJ" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggles" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
      -- { "<leader>z", group = "Spelling" },
    },
    win = {
      -- title = false,
      -- wo = {
      --   winblend = 100, -- value between 0-100 (fully opaque - fully transparent)
      -- },
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "WhichKeyTitle", { bg = "#000000" }) -- HACK: only works if border is black
    -- vim.api.nvim_set_hl(0, "WhichKeyFloat", { link = "WhichKeyBorder" })
    require("which-key").setup(opts)
  end,
}
