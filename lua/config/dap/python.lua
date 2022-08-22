local M = {}

function M.setup(_)
  require("dap-python").setup("python3", {})
end

return M
