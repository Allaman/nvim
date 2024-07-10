return {
  "goolord/alpha-nvim",
  init = false,
  enabled = function()
    local utils = require("utils.functions")
    local db = utils.safe_nested_config(vim.g.config, "dashboard")
    if db == "dashboard" then
      return false
    end
    return true -- alpha is the default dashboard
  end,
  event = "VimEnter",
  dependencies = {
    "famiu/bufdelete.nvim", -- for autocmd
  },
  config = function()
    require("utils.functions").dashboard_autocmd(":Alpha | bd#")
    -- Disable cursorline in alpha buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "alpha" }, -- Add other buffer types as needed
      callback = function()
        vim.opt_local.cursorline = false
      end,
    })
    -- Re-enable cursorline when entering other buffers
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        local ft = vim.bo.filetype
        if not vim.tbl_contains({ "alpha" }, ft) then
          vim.opt_local.cursorline = true
        end
      end,
    })
    require("core.plugins.alpha.alpha")
  end,
}
