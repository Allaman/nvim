local parsers = {
  "bash",
  "bicep",
  "cmake",
  "css",
  "dockerfile",
  "go",
  "hcl",
  "http",
  "html",
  "java",
  "javascript",
  "json",
  "kotlin",
  "ledger",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "python",
  "regex",
  "terraform",
  "templ",
  "toml",
  "typst",
  "vim",
  "yaml",
}

-- Equivalent of lazy.nvim's `build = ":TSUpdate"`.
-- Must be registered before vim.pack.add(), so it also catches installs.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and (event.data.kind == "install" or event.data.kind == "update") then
      if not event.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end

      vim.cmd.TSUpdate()
    end
  end,
})

local gh = require("config.util").gh
vim.pack.add({
  {
    src = gh("nvim-treesitter/nvim-treesitter"),
    version = "main",
  },
  gh("RRethy/nvim-treesitter-endwise"),
})

local ts = require("nvim-treesitter")

-- Install missing parsers.
-- install() is asynchronous and is a no-op for parsers already installed.
ts.install(parsers)

-- Enable Treesitter features for buffers with an installed parser.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    -- Highlighting
    local ok = pcall(vim.treesitter.start, event.buf)

    if not ok then
      return
    end

    -- Indentation
    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Folds
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
  end,
})
