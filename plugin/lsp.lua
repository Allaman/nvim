vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or "n", keys, func, {
        buffer = event.buf,
        desc = desc,
      })
    end

    map("<leader>lk", vim.lsp.buf.hover, "Hover")
    map("<leader>lR", vim.lsp.buf.rename, "Rename")
    map("<leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
    map("<leader>lD", vim.lsp.buf.declaration, "Declaration")
  end,
})

-- Shared configuration inherited by every native LSP config.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({
  "bashls",
  "dockerls",
  "gopls",
  "harper_ls",
  "lua_ls",
  "pyright",
  "terraformls",
  "tinymist",
  "taplo",
  "tsc",
  "yamlls",
})
