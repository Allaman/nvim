vim.api.nvim_exec(
  [[
    augroup Mafile
      autocmd!
      autocmd BufRead,BufNewFile Makefile,MAKEFILE set filetype=make
    augroup END
  ]],
  false
)
