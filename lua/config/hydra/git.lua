local Hydra = require("hydra")
local gitsigns = require("gitsigns")

local function cmd(command)
  return table.concat({ "<Cmd>", command, "<CR>" })
end

local hint = [[
 _J_: next hunk     _s_: stage hunk         _p_: preview hunk   _b_: toggle blame
 _K_: prev hunk     _u_: undo stage hunk    _d_: show deleted   _B_: blame show full
 _S_: stage buffer  _U_: undo stage buffer  _/_: show base file
 _r_: reset hunk    _R_: reset buffer       _g_: status
 _h_: Branches      _M_: checkout commit (current file)   _m_: checkout commit
 _c_: Commit buffer      _P_: Push
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
    { "h", cmd("Telescope git_branches"), { exit = true } },
    { "c", cmd("G commit %") },
    { "P", cmd("G push"), { exit = true } },
    { "m", cmd("Telescope git_commits"), { exit = true } },
    { "M", cmd("Telescope git_bcommits"), { exit = true } },
    { "g", cmd("Telescope git_status"), { exit = true } },
    { "s", gitsigns.stage_hunk, { silent = true } },
    { "R", gitsigns.reset_buffer },
    { "r", gitsigns.reset_hunk },
    { "u", gitsigns.undo_stage_hunk },
    { "U", gitsigns.undo_stage_buffer },
    { "S", gitsigns.stage_buffer },
    { "p", gitsigns.preview_hunk },
    { "d", gitsigns.toggle_deleted, { nowait = true } },
    { "b", cmd("GitBlameToggle"), { exit = true } },
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
