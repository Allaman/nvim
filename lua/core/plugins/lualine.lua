local user_conf = vim.g.config.plugins.lualine or {}

local default_options = {
  extensions = vim.g.config.plugins.lualine.extensions,
  options = {
    disabled_filetypes = { "neo-tree", "snacks_dashboard" },
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {}, -- hide mode
    lualine_b = {
      "branch",
      "diff",
      { "diagnostics", sources = { "nvim_lsp" } },
    },
    lualine_c = {
      {
        "filename",
        file_status = true, -- Displays file status (readonly status, modified status)
        newfile_status = true, -- Display new file status (new file means no write after created)
        path = 3, -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory
        -- 4: Filename and parent dir, with tilde as the home directory
      },
    },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}

local function default_config_function(opts)
  -- Show info when recording a macro
  local function is_macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
      return ""
    end
    return "󰑋 " .. reg
  end

  table.insert(opts.sections.lualine_x, 1, {
    is_macro_recording,
    color = { fg = "#333333", bg = "#ff6666" },
    separator = { left = "", right = "" },
    cond = function()
      return is_macro_recording() ~= ""
    end,
  })

  -- Don't display encoding if encoding is UTF-8
  local function encoding()
    local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
    return ret
  end

  table.insert(opts.sections.lualine_x, 1, {
    encoding,
    cond = function()
      return encoding() ~= ""
    end,
  })

  -- Don't display fileformat if fileformat is unix
  local function fileformat()
    local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
    return ret
  end

  table.insert(opts.sections.lualine_x, 1, {
    fileformat,
    cond = function()
      return fileformat() ~= ""
    end,
  })

  local function wordCount()
    local wc = vim.fn.wordcount()
    if wc == nil then
      return ""
    end
    if wc["visual_words"] then -- text is selected in visual mode
      return wc["visual_words"] .. " Words/" .. wc["visual_chars"] .. " Chars (Vis)"
    else -- all of the document
      return wc["words"] .. " Words"
    end
  end

  table.insert(opts.sections.lualine_y, 1, {
    wordCount,
    cond = function()
      local ft = vim.bo.filetype
      local count = {
        latex = true,
        tex = true,
        text = true,
        markdown = true,
        vimwiki = true,
      }
      return count[ft] ~= nil
    end,
  })

  require("lualine").setup(opts)
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = vim.tbl_deep_extend("force", default_options, (user_conf.opts or {})),
  config = function(_, opts)
    (user_conf.config_function or default_config_function)(opts)
  end,
}
