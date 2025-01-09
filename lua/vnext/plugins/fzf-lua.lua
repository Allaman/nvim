return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end,
    opts = {
      oldfiles = {
        cwd_only = true,
      },
      winopts = {
        preview = {
          default = "bat",
        },
        on_create = function()
          vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = 0 })
          vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = 0 })
        end,
      },
    },
    keys = {
      { "<leader>ss", "<cmd>FzfLua live_grep<cr>", desc = "Strings" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Open" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "List" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Doc Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Doc Workspace" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      -- { "<leader>r", "<cmd>FzfLua resume<cr>", desc = "Resume search" },
      { "<C-f>", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search in current buffer" },
    },
  },
}
