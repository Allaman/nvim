local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

--- highligh line number according to diagnostics
vim.diagnostic.config({
  signs = {
    -- text = {
    --   [vim.diagnostic.severity.ERROR] = "",
    --   [vim.diagnostic.severity.WARN] = "",
    --   [vim.diagnostic.severity.INFO] = "",
    --   [vim.diagnostic.severity.HINT] = "",
    -- },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
})

-- stylua: ignore start
map("n", "<leader>dj", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>dk", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "<leader>dc", function() vim.diagnostic.open_float() end, { desc = "Toggle current diagnostic" })
map("n", "<leader>dd", function() vim.diagnostic.setqflist() end, { desc = "Open quickfix" })
-- stylua: ignore end
