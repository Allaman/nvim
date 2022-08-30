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

 _=_: equalize _o_: only
 _p_: pick     _w_: shift   _W_: swap
 ^
 _q_: exit
]]

local pick_window = function()
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

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
    { "s", cmd("split"), { exit = true } },
    { "v", cmd("vsplit"), { exit = true } },
    { "c", cmd("close"), { exit = true } }, -- close current window
    { "o", cmd("only"), { exit = true } }, -- close all windows but current
    -- window resizing
    { "=", cmd("wincmd =") },
    { "k", cmd("wincmd +") },
    { "j", cmd("wincmd -") },
    { "h", cmd("wincmd <") },
    { "l", cmd("wincmd >") },
    -- move window around
    { "H", cmd("WinShift left") },
    { "J", cmd("WinShift down") },
    { "K", cmd("WinShift up") },
    { "L", cmd("WinShift right") },
    { "p", pick_window, { exit = true } }, -- pick window
    -- WinShift modes
    { "w", cmd("WinShift") },
    { "W", cmd("WinShift swap") },
    { "q", nil, { exit = true, nowait = true } },
  },
})
