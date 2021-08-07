local g = vim.g

vim.g.neoformat_try_formatprg = 1
g.neoformat_verbose = 0
g.neoformat_run_all_formatters = 0
g.neoformat_enabled_python = { "autopep8", "yapf", "docformatter" }
g.neoformat_enabled_javascript = { "prettier" }
g.neoformat_enabled_yaml = { "prettier" }
g.neoformat_yaml_prettier = { exe = "prettier", args = {"--single-quote", "false", "--parser", "yaml"}}
-- autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
-- autocmd BufWritePre * undojoin | Neoformat
vim.api.nvim_exec(
  [[
    augroup fmt
      autocmd!
      autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
    augroup END
  ]],
  false
)
