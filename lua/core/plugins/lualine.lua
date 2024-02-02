return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
  },
  opts = {
    extensions = vim.g.config.plugins.lualine.extensions,
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
  },
  config = function(_, opts)
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

    require("lualine").setup(opts)
  end,
}
