local M = {}

local trouble_enabled, _ = pcall(require, "trouble")
---@type table<string><function|string>
local lsp_key_mapping = {}

if trouble_enabled then
  lsp_key_mapping["document_diagnostics"] = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
  lsp_key_mapping["lsp_implementations"] = "<cmd>Trouble lsp_implementations toggle focus=false<cr>"
  lsp_key_mapping["lsp_document_symbols"] = "<cmd>Trouble symbols toggle<cr>"
  lsp_key_mapping["lsp_references"] = "<cmd>Trouble lsp_references toggle focus=false win.position=right<cr>"
  lsp_key_mapping["lsp_definitions"] = "<cmd>Trouble lsp_definitions toggle focus=false<cr>"
  lsp_key_mapping["lsp_type_definitions"] = "<cmd>Trouble lsp_type_definitions toggle focus=false<cr>"
  lsp_key_mapping["workspace_diagnostics"] = "<cmd>Trouble diagnostics toggle<cr>"
else
  lsp_key_mapping["document_diagnostics"] = "<cmd>FzfLua diagnostics_document<cr>"
  lsp_key_mapping["lsp_implementations"] = "<cmd>FzfLua lsp_implementations<cr>"
  lsp_key_mapping["lsp_document_symbols"] = "<cmd>FzfLua lsp_document_symbols<cr>"
  lsp_key_mapping["lsp_references"] = "<cmd>Fzflua lsp_references<cr>"
  lsp_key_mapping["lsp_definitions"] = "<cmd>FzfLua lsp_definitions<cr>"
  lsp_key_mapping["lsp_type_definitions"] = "<cmd>FzfLua lsp_typedefs<cr>"
  lsp_key_mapping["workspace_diagnostics"] = "<cmd>FzfLua diagnostics_workspace<cr>"
end

M._keys = {
  { "<leader>ll", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  -- { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  {
    "<leader>lR",
    function()
      require("inc_rename")
      return ":IncRename " .. vim.fn.expand("<cword>")
    end,
    expr = true,
    desc = "Rename",
    has = "rename",
  },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "<leader>ld", lsp_key_mapping["lsp_definitions"], desc = "Goto Definition", has = "definition" },
  { "<leader>lr", lsp_key_mapping["lsp_references"], desc = "References" },
  {
    "<leader>lI",
    lsp_key_mapping["lsp_implementations"],
    desc = "Goto Implementation",
  },
  { "<leader>lt", lsp_key_mapping["lsp_type_definitions"], desc = "Goto Type Definition" },
  { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
  { "<leader>lS", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  {
    "<leader>ln",
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    desc = "Next Diagnostic",
  },
  {
    "<leader>lp",
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    desc = "Prev Diagnostic",
  },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  { "<leader>ls", lsp_key_mapping["lsp_document_symbols"], desc = "Document Symbols" },
  { "<leader>le", lsp_key_mapping["document_diagnostics"], desc = "Document Diagnostics" },
  { "<leader>lws", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>lE", lsp_key_mapping["workspace_diagnostics"], desc = "Workspace Diagnostics" },
}

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(M._keys) do
    local keys = Keys.parse(value)
    if keys.rhs == vim.NIL or keys.rhs == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      ---@class LazyKeysBase
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
