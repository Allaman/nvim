return {
  {
    "A7Lavinraj/fyler.nvim",
    dev = true,
    keys = {
      { "-", "<cmd>lua require('fyler').toggle({kind = 'float'})<cr>", desc = "Fyler" },
      { "<leader>fp", "<cmd>lua require('fyler').toggle({kind = 'split_left_most'})<cr>", desc = "Toggle Filetree" },
    },
    init = function()
      -- Load fyler when nvim is started with a directory
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Fyler_start_directory", { clear = true }),
        desc = "Start Fyler with directory",
        once = true,
        callback = function()
          if package.loaded["fyler"] then
            return
          end
          local args = vim.fn.argv()
          local arg1 = args[1]
          -- Open fyler if one argument and that's a directory
          if #args == 1 and arg1 then
            local stats = vim.uv.fs_stat(arg1 --[[@as string]])
            if stats and stats.type == "directory" then
              require("fyler").open()
            end
          end
        end,
      })
    end,
    opts = {
      integrations = {
        winpick = "snacks",
      },
      views = {
        finder = {
          close_on_select = false,
          default_explorer = true,
          delete_to_trash = true,
          indentscope = {
            enabled = false,
          },
          mappings = {
            ["C-v"] = "SelectVSplit",
            ["C-s"] = "SelectSplit",
          },
          win = {
            kinds = {
              split_left_most = {
                width = "15%",
                win_opts = {
                  winfixwidth = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
