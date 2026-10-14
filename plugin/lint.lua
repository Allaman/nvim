local gh = require("config.util").gh

vim.pack.add({ gh("mfussenegger/nvim-lint") })

local lint = require("lint")

lint.linters_by_ft = {
  dockerfile = { "hadolint" },
  go = { "golangcilint" },
  javascript = { "oxlint" },
  lua = { "selene" },
  markdown = { "markdownlint-cli2" },
  terraform = { "tflint" },
  yaml = { "yamllint" },
}

local lint_augroup = vim.api.nvim_create_augroup("linting", {
  clear = true,
})

vim.api.nvim_create_autocmd({
  "BufWritePost",
  "BufReadPost",
  "InsertLeave",
}, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
