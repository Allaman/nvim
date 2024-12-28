local user_config = vim.g.config.plugins.fzf_lua or {}

local default_config = {
  enabled = true,
  opts = {
    oldfiles = {
      cwd_only = true,
    },
    winopts = {
      preview = {
        default = "bat",
      },
      on_create = function()
        vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
        vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
      end,
    },
  },
  keys = {
    { "<leader>ss", "<cmd>FzfLua live_grep<cr>", desc = "Strings" },
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help" },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Open" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "List" },
    -- { "<leader>r", "<cmd>FzfLua resume<cr>", desc = "Resume search" },
    { "<C-f>", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search in current buffer" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = config.keys,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end,
    opts = config.opts,
    -- config = function()
    -- calling `setup` is optional for customization
    -- require("fzf-lua").setup({})
    -- end,
  },
  -- catppuccin integration
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { fzf = true },
    },
  },
}
