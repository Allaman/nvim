local gl = require "galaxyline"
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
local colors = {
  bg = "#2E2E2E",
  -- bg = '#292D38',
  yellow = "#DCDCAA",
  dark_yellow = "#D7BA7D",
  cyan = "#4EC9B0",
  green = "#608B4E",
  light_green = "#B5CEA8",
  string_orange = "#CE9178",
  orange = "#FF8800",
  purple = "#C586C0",
  magenta = "#D16D9E",
  grey = "#858585",
  blue = "#569CD6",
  vivid_blue = "#4FC1FF",
  light_blue = "#9CDCFE",
  red = "#D16969",
  error_red = "#F44747",
  info_yellow = "#FFCC66",
}

local condition = require "galaxyline.condition"
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
        c = colors.magenta,
        no = colors.blue,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.red,
        Rv = colors.red,
        cv = colors.blue,
        ce = colors.blue,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.blue,
        t = colors.blue,
      }
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return "▊"
    end,
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})
-- print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, "ts")

table.insert(gls.left, {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineGit",
  },
})

table.insert(gls.left, {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.left, {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = "StatusLineGitAdd",
  },
})

table.insert(gls.left, {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " 柳",
    highlight = "StatusLineGitChange",
  },
})

table.insert(gls.left, {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = "StatusLineGitDelete",
  },
})

table.insert(gls.left, {
  Filler = {
    provider = function()
      return " "
    end,
    highlight = "StatusLineGitDelete",
  },
})

table.insert(gls.right, {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = "StatusLineLspDiagnosticsError",
  },
})
table.insert(gls.right, {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = "StatusLineLspDiagnosticsWarning",
  },
})

table.insert(gls.right, {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = "StatusLineLspDiagnosticsInformation",
  },
})

table.insert(gls.right, {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = "StatusLineLspDiagnosticsHint",
  },
})

table.insert(gls.right, {
  LineInfo = {
    provider = "LineColumn",
    separator = "  ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.right, {
  BufferType = {
    provider = "FileTypeName",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.right, {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.right, {
  Space = {
    provider = function()
      return " "
    end,
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = "StatusLineSeparator",
    highlight = "StatusLineNC",
  },
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,

    highlight = "StatusLineNC",
  },
})

--table.insert(gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}})
