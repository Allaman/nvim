local user_config = vim.g.config.plugins.gitsigns or {}

local default_config = {
  enabled = true,
  keys = {
    { "<leader>g", "", desc = "+Git" },
  },
  opts = {
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end
      map("n", "gj", gs.next_hunk, "Git next hunk")
      map("n", "gk", gs.prev_hunk, "Git previous hunk")
      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>gB", gs.blame, "Blame")
      map("n", "<leader>gb", gs.toggle_current_line_blame, "Blame line")
      map("n", "<leader>gD", gs.diffthis, "Diff")
      map("n", "<leader>gd", gs.toggle_deleted, "Show deleted")
      map({ "o", "x" }, "gH", "<cmd><C-U>Gitsigns select_hunk<cr>", "Select hunk")
    end,
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = config.opts,
    keys = config.keys,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
