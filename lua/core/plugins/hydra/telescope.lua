local Hydra = require("hydra")

local function cmd(command)
  return table.concat({ "<Cmd>", command, "<CR>" })
end

local hint = [[
 _f_: files          _p_: projects
 _t_: live grep      _s_: grep string
 _H_: header         _S_: symbols
 _R_: register       _P_: plugins
 _h_: vim help       _c_: execute command
 _k_: keymaps        _;_: commands history
 _O_: options        _?_: search history
 _/_: search in file _m_: make
 _r_: recently opened files

 ^
 _<Enter>_: Telescope   _q_: Exit
]]

Hydra({
  name = "Telescope",
  hint = hint,
  config = {
    invoke_on_body = true,
    hint = {
      position = "middle",
      border = "rounded",
    },
  },
  mode = "n",
  body = "<Leader>s",
  heads = {
    { "c", cmd("Telescope commands"), { desc = "execute command" } },
    { "f", cmd("Telescope find_files") },
    { "t", cmd("Telescope live_grep") },
    { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
    { "H", cmd("Telescope heading") },
    { "k", cmd("Telescope keymaps") },
    { "O", cmd("Telescope vim_options") },
    { "m", cmd("Telescope make") },
    { "p", cmd("Telescope projects"), { desc = "projects" } },
    { "P", cmd("Telescope packer") },
    { "r", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
    { "R", cmd("Telescope registers") },
    { "s", cmd("Telescope grep_string"), { desc = "Text under cursor" } },
    { "S", cmd("Telescope symbols") },
    { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
    { "?", cmd("Telescope search_history"), { desc = "search history" } },
    { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
    { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
    { "q", nil, { exit = true, nowait = true } },
  },
})
