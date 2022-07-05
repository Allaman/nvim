local Hydra = require("hydra")
local gitsigns = require("gitsigns")

local hint = [[
 _J_: next hunk     _s_: stage hunk        _p_: preview hunk _b_: blame line
 _K_: prev hunk     _u_: undo stage hunk   _d_: show deleted _B_: blame show full
 _S_: stage buffer  _U_: undo stage buffer _/_: show base file
 _r_: reset hunk  _R_: reset buffer        _g_: status
 _h_: Branches      _C_: checkout commit (current file) _c_: checkout commit
 ^
 _<Enter>_: Neogit              _q_: exit
]]

Hydra({
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
  },
  mode = { "n", "x" },
  body = "<leader>g",
  heads = {
    {
      "J",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    {
      "K",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    { "h", "<cmd>Telescope git_branches<cr>" },
    { "c", "<cmd>Telescope git_commits<cr>" },
    { "C", "<cmd>Telescope git_bcommits<cr>" },
    { "g", "<cmd>Telescope git_status<cr>" },
    { "s", gitsigns.stage_hunk, { silent = true } },
    { "R", gitsigns.reset_buffer },
    { "r", gitsigns.reset_hunk },
    { "u", gitsigns.undo_stage_hunk },
    { "U", gitsigns.undo_stage_buffer },
    { "S", gitsigns.stage_buffer },
    { "p", gitsigns.preview_hunk },
    { "d", gitsigns.toggle_deleted, { nowait = true } },
    { "b", gitsigns.blame_line },
    {
      "B",
      function()
        gitsigns.blame_line({ full = true })
      end,
    },
    { "/", gitsigns.show, { exit = true } }, -- show the base of the file
    { "<Enter>", "<cmd>Neogit<CR>", { exit = true } },
    { "q", nil, { exit = true, nowait = true } },
  },
})
