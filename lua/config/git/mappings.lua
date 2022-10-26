local wk = require("which-key")
local default_options = { silent = true }
local gs = package.loaded.gitsigns
local map = require("utils").map

M = {}

function M.setup()
  wk.register({
    g = {
      name = "Git",
      M = { "Hydra move" },
      ["<Enter>"] = { "<cmd>lua require('neogit').open()<cr>", "Neogit" },
      h = { "<cmd>Telescope git_branches<cr>", "Branches" },
      c = { "<cmd>G commit %<cr>", "Commit buffer" },
      P = { "<cmd>G push<cr>", "Push" },
      g = { "<cmd>Telescope git_status<cr>", "Status" },
      m = { "<cmd>Telescope git_commits<cr>", "Commits" },
      S = { gs.stage_buffer, "Stage buffer" },
      u = { gs.undo_stage_hunk, "Undo stage hunk" },
      r = {
        name = "Reset",
        R = { gs.reset_buffer, "Reset buffer" },
      },
      p = { gs.preview_hunk, "Preview hunk" },
      B = {
        function()
          gs.blame_line({ full = true })
        end,
        "Blame full",
      },
      b = { gs.toggle_current_line_blame, "Blame line" },
      D = { gs.diffthis, "Diff" },
      d = { gs.toggle_deleted, "Show deleted" },
    },
  }, { prefix = "<leader>", mode = "n", default_options })

  -- TODO with german qwertz this bindings are awful
  map("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { desc = "Next hunk", expr = true })

  map("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { desc = "Previous hunk", expr = true })

  map({ "n", "v" }, "<leader>grr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
  map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
  map({ "o", "x" }, "gH", "<cmd><C-U>Gitsigns select_hunk<cr>", { desc = "Select hunk" })
end

return M
