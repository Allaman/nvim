local user_config = vim.g.config.plugins.gp

local default_options = {
  hooks = {
    Translator = function(gp, params)
      local agent = gp.get_command_agent()
      local chat_system_prompt = "You are a Translator, please translate between German and English."
      gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
    end,
  },
}

local default_keys = {
  { "<leader>iv", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat (vsplit)" },
  { "<leader>it", "<cmd>GpChatToggle<cr>", desc = "Toggle last chat" },
  { "<leader>if", "<cmd>GpChatFinder<cr>", desc = "Find chat" },
  { "<leader>id", "<cmd>GpChatDelete<cr>", desc = "Delete current chat" },
  { "<leader>ii", "<cmd>GpImage<cr>", desc = "Create an image" },
  { "<leader>is", "<cmd>GpStop<cr>", desc = "Stop all running jobs and responses" },
  { "<leader>il", "<cmd>GpTranslator vsplit<cr>", desc = "Translate" },
}

return {
  {
    "robitx/gp.nvim",
    lazy = true,
    enabled = user_config.enabled,
    keys = vim.tbl_deep_extend("force", default_keys, (user_config.keys or {})),
    opts = vim.tbl_deep_extend("force", default_options, (user_config.opts or {})),
    config = function(_, opts)
      require("gp").setup(opts)
    end,
  },
  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      groups = {
        ["<leader>i"] = { name = "AI" },
      },
    },
  },
}
