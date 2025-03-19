return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>fp", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle Filetree" },
    },
    init = function()
      -- Load neo-tree when nvim is started with a directory
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      default_component_configs = {
        indent = {
          with_markers = false,
        },
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
            -- MacOS
            if vim.fn.executable("open") == 1 then
              vim.api.nvim_command("silent !open -g " .. path)
            -- Linux
            elseif vim.fn.executable("xdg-open") == 1 then
              vim.api.nvim_command("silent !xdg-open " .. path)
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
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
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
        hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
      },
    },
    config = function(_, opts)
      -- no background for Neotree
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
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
  },
}
