local gh = require("config.util").gh

vim.pack.add({ gh("Bekaboo/dropbar.nvim") })

require("dropbar").setup({
  bar = {
    enable = function(buf, win, _)
      local filetype = vim.bo[buf].filetype
      local disabled_filetypes = {
        ["nvim-undotree"] = true,
      }

      if filetype == "" then
        return false
      end

      if disabled_filetypes[filetype] then
        return false
      end

      -- TODO: keep only with codediff
      -- Disable in codediff.nvim diff panes: only one side is a real
      -- file buffer, so a one-sided winbar offsets the diff by a line.
      if vim.w[win].codediff_restore then
        return false
      end

      -- Reproduce the default enable conditions
      return vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_win_is_valid(win)
        and vim.bo[buf].buftype == ""
        and not vim.api.nvim_win_get_config(win).zindex
    end,
  },
})

-- No background for dropbar
vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
