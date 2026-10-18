local gh = require("config.util").gh

vim.pack.add({ gh("stevearc/conform.nvim") })

local opts = {
  format_on_save = function(bufnr)
    if not vim.g.autoformat then
      return
    end
    local lsp_fallback = vim.bo[bufnr].filetype == "typst" and true or false
    return { timeout_ms = 500, lsp_fallback = lsp_fallback }
  end,
  -- log_level = vim.log.levels.TRACE,
  formatters_by_ft = {
    dockerfile = { "dockerfmt" },
    go = { "goimports", "gofumpt" },
    javascript = { "oxfmt" },
    json = { "oxfmt" },
    lua = { "stylua" },
    markdown = { "oxfmt" },
    python = { "isort", "ruff_format" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    tex = { "latexindent" },
    toml = { "taplo" },
    xml = { "xmllint" },
    yaml = { "yamlfmt" },
  },
}

local conform = require("conform")
conform.setup(opts)
conform.formatters.shfmt = {
  prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
}
conform.formatters.stylua = {
  prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
}
conform.formatters.yamlfmt = {
  prepend_args = {
    "-formatter",
    "indent=2",
    "-formatter",
    "include_document_start=true",
    "-formatter",
    "retain_line_breaks_single=true",
  },
}
vim.g.autoformat = vim.g.autoformat
vim.api.nvim_create_user_command("ToggleAutoformat", function()
  vim.notify("Toggling autoformat", vim.log.levels.INFO, { title = "conform.nvim", timeout = 2000 })
  vim.g.autoformat = vim.g.autoformat == false and true or false
end, { desc = "Toggling autoformat" })
vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })

conform.setup(opts)
