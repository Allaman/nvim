-- force tf files to filetype terraform
vim.api.nvim_exec([[
    augroup terraform
      autocmd!
      autocmd BufRead,BufNewFile *.tf set filetype=terraform
      autocmd BufWritePost *.tf FormatWrite
    augroup END
  ]], false)
