-- Lualine configuration with helper functions

-- Configuration constants
local DEFAULT_ENCODING = "utf-8"
local DEFAULT_FILEFORMAT = "unix"
local WORDCOUNT_FILETYPES = {
  latex = true,
  tex = true,
  text = true,
  markdown = true,
  vimwiki = true,
  rst = true,
  asciidoc = true,
  org = true,
}

-- Helper functions with better error handling and robustness
local function is_not_unix_fileformat()
  local format = vim.bo.fileformat
  return format and format ~= DEFAULT_FILEFORMAT
end

local function is_not_utf8_coding()
  local encoding = vim.bo.fileencoding
  -- Handle empty encoding (which defaults to utf-8 in nvim)
  return encoding and encoding ~= "" and encoding ~= DEFAULT_ENCODING
end

local function is_macro_recording()
  local rec = vim.fn.reg_recording()
  return rec and rec ~= ""
end

local function get_macro_recording()
  local reg = vim.fn.reg_recording()
  if not reg or reg == "" then
    return ""
  end
  return "󰑋 " .. reg
end

local function get_word_count()
  -- Protected call to handle potential errors
  local ok, wc = pcall(vim.fn.wordcount)
  if not ok or not wc then
    return ""
  end

  -- Handle visual mode selection
  if wc.visual_words and wc.visual_chars then
    return string.format("%d Words/%d Chars (Vis)", wc.visual_words, wc.visual_chars)
  end

  -- Handle regular document word count
  if wc.words then
    return string.format("%d Words", wc.words)
  end
  return ""
end

local function is_document_filetype()
  local filetype = vim.bo.filetype
  return filetype and WORDCOUNT_FILETYPES[filetype] or false
end

-- Main configuration
return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPost",
  opts = {
    extensions = { "lazy", "quickfix", "neo-tree" },
    options = {
      disabled_filetypes = {
        statusline = { "neo-tree", "Outline", "snacks_picker_list", "Fyler" },
      },
    },
    sections = {
      lualine_a = {}, -- hide mode
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
        "lsp_status",
      },
      lualine_c = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          --- path 0: filename 1: rel path 2: abs path 3: abs path with ~ 4: fn with parent dir
          path = 3,
        },
      },
      lualine_x = {
        {
          "encoding",
          cond = is_not_utf8_coding,
          show_bomb = true,
        },
        {
          "fileformat",
          cond = is_not_unix_fileformat,
        },
        "searchcount",
        "filetype",
        {
          get_macro_recording,
          cond = is_macro_recording,
          color = { fg = "#333333", bg = "#ff6666" },
          separator = { left = "", right = "" },
        },
      },
      lualine_y = {
        {
          get_word_count,
          cond = is_document_filetype,
          icon = "󰈭",
        },
        "progress",
      },
      lualine_z = { "location" },
    },
    -- inactive sections to match
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
