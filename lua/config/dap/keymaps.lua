local M = {}

local wk = require("which-key")

function M.setup()
  wk.register({
    d = { "<cmd>lua require('hydra').spawn('dap-hydra')<cr>", "Debug" },
  }, { prefix = "<leader>", mode = "n", { silent = true } })
end

return M
