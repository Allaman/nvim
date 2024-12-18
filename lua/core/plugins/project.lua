local fzf_lua = require("fzf-lua")

local M = {
  "ahmedkhalf/project.nvim",
  keys = {
    {
      "<leader>sp",
      function()
        local history = require("project_nvim.utils.history")
        fzf_lua.fzf_exec(function(cb)
          local results = history.get_recent_projects()
          for _, e in ipairs(results) do
            cb(e)
          end
          cb()
        end, {
          actions = {
            ["default"] = {
              function(selected)
                fzf_lua.files({ cwd = selected[1] })
              end,
            },
            ["ctrl-d"] = {
              function(selected)
                history.delete_project({ value = selected[1] })
              end,
              fzf_lua.actions.resume,
            },
          },
        })
      end,
      desc = "Projects",
    },
  },
  opts = {
    -- neo-tree integration
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    patterns = {
      ".git",
      "package.json",
      ".terraform",
      "go.mod",
      "requirements.yml",
      "pyrightconfig.json",
      "pyproject.toml",
    },
    -- detection_methods = { "lsp", "pattern" },
    detection_methods = { "pattern" },
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}

return M
