local M = {}

local trouble_enabled = vim.g.config.plugins.trouble.enable
---@type table<string><function|string>
local lsp_key_mapping = {}

if trouble_enabled then
  lsp_key_mapping["workspace_diagnostics"] = function()
    require("trouble").toggle("workspace_diagnostics")
  end
  lsp_key_mapping["document_diagnostics"] = function()
    require("trouble").toggle("document_diagnostics")
  end
  lsp_key_mapping["lsp_references"] = function()
    require("trouble").toggle("lsp_references")
  end
  lsp_key_mapping["lsp_definitions"] = function()
    require("trouble").toggle("lsp_definitions")
  end
  lsp_key_mapping["lsp_type_definitions"] = function()
    require("trouble").toggle("lsp_type_definitions")
  end
else
  lsp_key_mapping["workspace_diagnostics"] = "<cmd>Telescope diagnostics<cr>"
  lsp_key_mapping["document_diagnostics"] = "<cr>Telescope diagnostics bufnr=0<cr>"
  lsp_key_mapping["lsp_references"] = "<cmd>Telescope lsp_references<cr>"
  lsp_key_mapping["lsp_definitions"] = function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end
  lsp_key_mapping["lsp_type_definitions"] = function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end
end

M._keys = {
  { "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
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
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end,
    desc = "Goto Implementation",
  },
  { "<leader>lt", lsp_key_mapping["lsp_type_definitions"], desc = "Goto Type Definition" },
  { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
  { "<leader>lS", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  { "<leader>ln", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>lp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>le", lsp_key_mapping["document_diagnostics"], desc = "Document Diagnostics" },
  { "<leader>lws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>lwd", lsp_key_mapping["workspace_diagnostics"], desc = "Workspace Diagnostics" },
  { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" },
  { "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", desc = "List Folders" },
  { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" },
}

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}
  local wk = require("which-key")

  wk.register({
    l = {
      w = { "Workspaces" },
    },
  }, { prefix = "<leader>", mode = "n" })

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
