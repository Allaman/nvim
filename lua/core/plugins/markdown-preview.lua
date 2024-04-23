local user_config = vim.g.config.plugins.markdown_preview or {}

local default_config = {
  enabled = false,
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "iamcco/markdown-preview.nvim",
  enabled = config.enabled,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
