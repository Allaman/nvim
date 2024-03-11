local user_conf = vim.g.config.plugins.lualine
local default_options = {
  extensions = vim.g.config.plugins.lualine.extensions,
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_b = { "branch", "diff", "diagnostics" },
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
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}

local function default_config_function(opts)
  if vim.g.config.plugins.copilot.enable then
    local lsp_utils = require("core.plugins.lsp.utils")
    local utils = require("utils.functions")
    local function list_LSP_clients()
      local clients = lsp_utils.get_LSP_clients()
      local list = {}
      for _, client in ipairs(clients) do
        table.insert(list, client.name)
        -- TODO only indicate a running copilot?
        -- if client.name == "copilot" then
        --   local icons = require("utils.icons")
        --   return icons.apps.Copilot
        -- end
      end
      return table.concat(list, "|")
    end
    opts.sections.lualine_a = {
      {
        list_LSP_clients,
        cond = function()
          return utils.table_length(lsp_utils.get_LSP_clients()) > 0
        end,
      },
    }
  end

  local function is_macro_recording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
      return ""
    end
    return "Recording to " .. reg
  end

  -- Show info when recording a macro
  table.insert(opts.sections.lualine_x, 1, {
    is_macro_recording,
    color = { fg = "red", gui = "italic" },
    cond = function()
      return is_macro_recording() ~= ""
    end,
  })

  require("lualine").setup(opts)
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
  },
  opts = vim.tbl_deep_extend("force", default_options, user_conf.opts),
  config = function(_, opts)
    (user_conf.config_function or default_config_function)(opts)
  end,
}
