local utils = require("utils.functions")
local api = vim.api

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

api.nvim_create_autocmd("Filetype", {
  pattern = "mail",
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
  end,
  desc = "wrap words 'softly' (no carriage return) in mail buffer",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  callback = function()
    vim.api.nvim_command("set filetype=typst")
  end,
  desc = "detect typst filetype",
})

-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
-- expects a terraform filetype and not a tf filetype
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf" },
  callback = function()
    vim.api.nvim_command("set filetype=terraform")
  end,
  desc = "detect terraform filetype",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "terraform-vars",
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
  desc = "detect terraform vars",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "*tf", "*.hcl" },
  desc = "fix terraform and hcl comment string",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("FixNixCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "*.nix" },
  desc = "fix nix comment string",
})

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "highlight on yank",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-float",
    "fugitive",
    "grug-far",
    "help",
    "man",
    "notify",
    "qf",
    "PlenaryTestPopup",
    "startuptime",
    "query",
    "spectre_panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

api.nvim_create_autocmd(
  "FileType",
  { pattern = { "NeoGitStatus" }, command = [[setlocal list!]], desc = "disable list option in certain filetypes" }
)

local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
  desc = "show cursor line only in active window",
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { "*.txt", "*.md", "*.tex", "*.typ" },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = "en,de"
    end,
    desc = "Enable spell checking for certain file types",
  }
)

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_get_name(0) == "" and vim.bo.modified == false and vim.bo.buftype == "" then
      local bmap = vim.api.nvim_buf_set_keymap
      bmap(0, "n", "q", "<cmd>qa<cr>", { desc = "Quit" })
    end
  end,
  desc = "Exit Empty Buffer with q",
})
