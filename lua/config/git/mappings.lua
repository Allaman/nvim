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
      ["<Enter>"] = { "<cmd>Neogit<cr>", "Neogit" },
      h = { "<cmd>Telescope git_branches", "Branches" },
      c = { "<cmd>G commit %", "Commit buffer" },
      P = { "<cmd>G push", "Push" },
      g = { "<cmd>Telescope git_status", "Status" },
      m = { "<cmd>Telescope git_commits", "Commits" },
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

  map({ "n", "v" }, "<leader>grr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
  map({ "o", "x" }, "gH", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
end

return M
