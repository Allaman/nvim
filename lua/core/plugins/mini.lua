local utils = require("utils.functions")
return {

  {
    "echasnovski/mini.comment",
    -- built-in in Neovim 10
    -- https://github.com/neovim/neovim/pull/28176
    -- TODO: https://github.com/folke/ts-comments.nvim
    enabled = not utils.isNeovimVersionsatisfied(10),
    event = { "BufReadPre", "BufNewFile" },
    -- is not loaded without explicitly saying it
    config = true,
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Number of lines within which surrounding is searched
      n_lines = 50,
    },
    config = function(_, opts)
      vim.keymap.set(
        "n",
        "<leader><leader>s",
        ":normal saiW`<Esc>",
        { desc = "Surround inner word with backticks", noremap = true }
      )
      local wk = require("which-key")
      wk.register({
        sa = "Add surrounding",
        sd = "Delete surrounding",
        sh = "Highlight surrounding",
        sn = "Surround update n lines",
        sr = "Replace surrounding",
        sF = "Find left surrounding",
        sf = "Find right surrounding",
        st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
      })
      require("mini.surround").setup(opts)
    end,
  },

  {
    "echasnovski/mini.align",
    event = { "BufReadPre", "BufNewFile" },
    -- is not loaded without explicitly saying it
    config = true,
  },

  {
    "echasnovski/mini.test",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        -- Whether to show preview of directory under cursor
        preview = true,
      },
    },
    config = function(_, opts)
      local show_dotfiles = true
      local filter_show = function()
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "H", toggle_dotfiles, { desc = "Toggle hidden files", buffer = buf_id })
        end,
      })
      require("mini.files").setup(opts)
    end,
    keys = {
      {
        "-",
        function()
          MiniFiles.open()
        end,
        desc = "Open Mini Files",
      },
    },
  },

  {
    "echasnovski/mini.ai",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
        },
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    commit = "b5e40acb2f0de7127bbcf026f3a0a55189a428a4",
    init = function()
      -- From https://github.com/LazyVim/LazyVim/blob/5115b585e7df4cedb519734ffc380b7e48a366f1/lua/lazyvim/util/mini.lua
      package.preload["nvim-web-devicons"] = function()
        local Icons = require("mini.icons")
        local ret = {}
        package.loaded["nvim-web-devicons"] = ret
        Icons.mock_nvim_web_devicons()

        local function get(cat)
          local all = {}
          for _, name in ipairs(Icons.list(cat)) do
            local icon, color = ret.get_icon_color(cat == "file" and name, cat == "extension" and name)
            all[name] = { icon = icon, color = color }
          end
          return all
        end

        ret.get_icons_by_extension = function()
          return get("extension")
        end

        ret.get_icons_by_filename = function()
          return get("file")
        end

        ret.get_icons = function()
          return vim.tbl_extend("force", get("file"), get("extension"))
        end
        return ret
      end
    end,
  },
}
