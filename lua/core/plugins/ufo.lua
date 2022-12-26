local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async"
  }
}

function M.config()
  require("ufo").setup()
end

return M
