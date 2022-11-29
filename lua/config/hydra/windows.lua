local Hydra = require("hydra")
local picker = require("window-picker")

local function cmd(command)
  return table.concat({ "<Cmd>", command, "<CR>" })
end

local hint = [[
 Move    Size    Splits
 -----  ------  ---------
 ^ ^ _K_ ^ ^   ^ ^ _k_ ^ ^  _s_: horizontally
 _H_ ^ ^ _L_   _h_ ^ ^ _l_  _v_: vertically
 ^ ^ _J_ ^ ^   ^ ^ _j_ ^ ^  _c_: close

 _=_: equalize _m_: toggle maximize
 _p_: pick
 _r_: Rotate down/right   _R_: rotate up/left
 ^
 _q_: exit
]]

local pick_window = function()
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

local opts = { exit = true, nowait = true }

Hydra({
  name = "Windows",
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "middle",
      border = "rounded",
    },
  },
  mode = "n",
  body = "<leader>w",
  heads = {
    { "s", cmd("split"), opts },
    { "v", cmd("vsplit"), opts },
    { "c", cmd("close"), opts }, -- close current window
    { "m", cmd("WindowsMaximize"), opts }, -- maximize current window
    -- window resizing
    { "=", cmd("wincmd =") },
    { "k", cmd("wincmd +") },
    { "j", cmd("wincmd -") },
    { "h", cmd("wincmd <") },
    { "l", cmd("wincmd >") },
    -- move window around
    { "H", cmd("wincmd H") },
    { "J", cmd("wincmd J") },
    { "K", cmd("wincmd K") },
    { "L", cmd("wincmd L") },
    -- rotate window
    { "r", cmd("windcmd r") },
    { "R", cmd("windcmd R") },
    -- pick window
    { "p", pick_window, opts },
    { "q", nil, opts },
  },
})
