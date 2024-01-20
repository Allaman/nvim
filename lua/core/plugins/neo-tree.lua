local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
      "s1n7ax/nvim-window-picker",
      lazy = true,
      opts = {
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = {
              "neo-tree",
              "neo-tree-popup",
              "notify",
              "packer",
              "qf",
              "diff",
              "fugitive",
              "fugitiveblame",
            },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "nofile", "help", "terminal" },
          },
        },
      },
    },
  },
  keys = {
    { "<leader>fp", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle Filetree" },
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    default_component_configs = {
      name = {
        highlight_opened_files = true,
      },
    },
    filesystem = {
      commands = {
        -- Override delete to use trash instead of rm
        delete = function(state)
          local path = state.tree:get_node().path
          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
          require("neo-tree.sources.manager").refresh(state.name)
        end,
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local utils = require("utils.functions")
          if utils.getOS() == "Darwin" then
            vim.api.nvim_command("silent !open -g " .. path)
          elseif utils.getOS() == "Linux" then
            vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
          else
            vim.notify("Could not determine OS", vim.log.levels.ERROR)
          end
        end,
      },
      window = {
        mappings = {
          ["o"] = "system_open",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          --["/"] = "filter_as_you_type", -- this was the default until v1.28
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ["<2-LeftMouse>"] = "open_with_window_picker",
          ["<cr>"] = "open_with_window_picker",
          -- ["S"] = "open_split",
          ["S"] = "split_with_window_picker",
          -- ["s"] = "open_vsplit",
          ["s"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          --["P"] = "toggle_preview",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          --["Z"] = "expand_all_nodes",
          ["R"] = "refresh",
          ["a"] = {
            "add",
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["A"] = "add_directory", -- also accepts the config.show_path option.
          ["d"] = "noop", -- unbind delete
          ["dd"] = "delete", -- bind delete to new mapping
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
          ["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
          ["q"] = "close_window",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
      -- "open_current",-- netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}

return M
