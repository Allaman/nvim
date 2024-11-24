local user_config = vim.g.config.plugins.gitsigns or {}

local default_config = {
  enabled = true,
  keys = {
    { "<leader>g", "", desc = "+Git" },
  },
  opts = {
    current_line_blame_opts = {
      delay = 0,
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- stylua: ignore start
      map("n", "gj", function() gs.nav_hunk("next") end, { desc = "Git Next hunk" })
      map("n", "gk", function() gs.nav_hunk("prev") end, { desc = "Git previous hunk" })
      map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
      map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
      map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      -- -- map("n", "<leader>gB", gs.blame, "Blame")
      map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Blame line" })
      map("n", "<leader>gD", gs.diffthis, {desc="Diff"})
      map("n", "<leader>gd", gs.toggle_deleted, { desc = "Show deleted" })
    end,
    -- stylua: ignore end
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
