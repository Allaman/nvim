local M = {
  "lervag/vimtex",
  ft = "tex",
  config = function()
    local conf = vim.g.config.plugins.tex
    local g = vim.g
    g.tex_flavor = "latex"
    -- TODO: config for winodows - if vim.fn.has("win32")
    if vim.fn.has("unix") == 1 then
      g.vimtex_view_method = conf.vimtex_view_method
      g.vimtex_view_skim_sync = 1
      g.vimtex_view_skim_activate = 1
    end
    g.vimtex_compiler_method = conf.vimtex_compiler_method
    g.vimtex_mappings_enabled = false
    -- Do not auto open quickfix on compile errors
    g.vimtex_quickfix_mode = 0
    -- vimtex toc options
    g.vimtex_toc_config = {
      split_pos = "rightbelow",
      split_width = 20,
      show_help = 0,
    }
    -- Latex warnings to ignore
    g.vimtex_quickfix_ignore_filters = {
      "Command terminated with space",
      "LaTeX Font Warning: Font shape",
      "Package caption Warning: The option",
      [[Underfull \\hbox (badness [0-9]*) in]],
      "Package enumitem Warning: Negative labelwidth",
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
      [[Package caption Warning: Unused \\captionsetup]],
      "Package typearea Warning: Bad type area settings!",
      [[Package fancyhdr Warning: \\headheight is too small]],
      [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
      "Package hyperref Warning: Token not allowed in a PDF string",
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
    }
  end,
}

return M
