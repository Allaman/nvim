local M = {
  "ironhouzi/starlite-nvim",
  config = function()
    local map = vim.keymap.set
    local default_options = { silent = true }
    map("n", "*", ":lua require'starlite'.star()<cr>", default_options)
    map("n", "g*", ":lua require'starlite'.g_star()<cr>", default_options)
    map("n", "#", ":lua require'starlite'.hash()<cr>", default_options)
    map("n", "g#", ":lua require'starlite'.g_hash()<cr>", default_options)
  end,
}

return M
