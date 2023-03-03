local opts = {
  auxDirectory = ".",
  bibtexFormatter = "texlab",
  build = {
    args = {
      "--keep-intermediates",
      "--keep-logs",
      "--synctex",
      "%f",
    },
    executable = "tectonic",
    forwardSearchAfter = false,
    onSave = false,
  },
  chktex = { onEdit = false, onOpenAndSave = false },
  diagnosticsDelay = 300,
  formatterLineLength = 80,
  forwardSearch = { args = {} },
  latexFormatter = "latexindent",
  latexindent = { modifyLineBreaks = false },
}

return opts
