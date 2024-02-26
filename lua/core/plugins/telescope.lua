local conf = vim.g.config.plugins
local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "jvgrootveld/telescope-zoxide",
    "crispgm/telescope-heading.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = conf.telescope.fzf_native.enable, build = "make" },
  },
  keys = {
    -- Search stuff
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Strings" },
    { "<leader>s?", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>sh", "<cmd>Telescope heading<cr>", desc = "Headings" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sO", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
    { "<leader>sS", "<cmd>Telescope symbols<cr>", desc = "Emoji" },
    { "<leader>s:", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    { "<leader>s;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
    {
      "<leader>sW",
      "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }<cr>",
      desc = "Word search",
    },
    -- Git
    { "<leader>gh", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>gg", "<cmd>Telescope git_status<cr>", desc = "Status" },
    { "<leader>gm", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    -- files
    { "<leader>fb", "<cmd>Telescope file_browser grouped=true<cr>", desc = "Filebrowser" },
    { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
    { "<leader>ff", "<cmd>" .. require("utils.functions").project_files() .. "<cr>", desc = "Open file" },
    { "<leader>fF", "<cmd>Telescope find_files<cr>", desc = "Open file (ignore git)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    -- misc
    { "<leader>mt", "<cmd>Telescope<cr>", desc = "Telescope" },
    -- Other
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Bufferlist" },
    { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local icons = require("utils.icons")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    if conf.telescope.grep_hidden then
      table.insert(vimgrep_arguments, "--hidden")
    end
    -- trim the indentation at the beginning of presented line
    table.insert(vimgrep_arguments, "--trim")

    local fzf_extension = {}
    if conf.telescope.fzf_native.enable then
      fzf_extension = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    end

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        fzf = fzf_extension,
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
          hidden = true,
          mappings = {
            i = {
              ["<c-n>"] = fb_actions.create,
              ["<c-r>"] = fb_actions.rename,
              -- ["<c-h>"] = actions.which_key,
              ["<c-h>"] = fb_actions.toggle_hidden,
              ["<c-x>"] = fb_actions.remove,
              ["<c-p>"] = fb_actions.move,
              ["<c-y>"] = fb_actions.copy,
              ["<c-a>"] = fb_actions.select_all,
            },
          },
        },
      },
      pickers = {
        find_files = {
          hidden = false,
        },
        oldfiles = {
          cwd_only = true,
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
        live_grep = {
          only_sort_text = true, -- grep for content and not file name/path
          mappings = {
            i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
          },
        },
      },
      defaults = {
        file_ignore_patterns = conf.telescope.file_ignore_patterns,
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            -- Close on first esc instead of going to normal mode
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-l>"] = actions.send_to_qflist,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<cr>"] = actions.select_default,
            ["<c-v>"] = actions.select_vertical,
            ["<c-s>"] = actions.select_horizontal,
            ["<c-t>"] = actions.select_tab,
            ["<c-p>"] = action_layout.toggle_preview,
            ["<c-o>"] = action_layout.toggle_mirror,
            ["<c-h>"] = actions.which_key,
            ["<c-x>"] = actions.delete_buffer,
          },
        },
        prompt_prefix = table.concat({ icons.arrows.ChevronRight, " " }),
        selection_caret = icons.arrows.CurvedArrowRight,
        entry_prefix = "  ",
        multi_icon = icons.arrows.Diamond,
        initial_mode = "insert",
        scroll_strategy = "cycle",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.95,
          height = 0.85,
          preview_cutoff = 25,
          prompt_position = "top",
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
          flex = { horizontal = { preview_width = 0.9 } },
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      },
    })

    telescope.load_extension("projects")
    telescope.load_extension("zoxide")
    telescope.load_extension("heading")
    if conf.noice.enable then
      telescope.load_extension("noice")
    end
    if conf.telescope.fzf_native.enable then
      telescope.load_extension("fzf")
    end
    if conf.emoji.enable then
      telescope.load_extension("emoji")
    end
  end,
}

return M
