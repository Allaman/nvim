local user_config = vim.g.config.plugins.bqf or {}

local default_config = {
  enabled = false,
  opts = {
    auto_enable = true,
    auto_resize_height = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      should_preview_cb = function(bufnr, qwinid)
        local ret = true
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(bufname)
        if fsize > 100 * 1024 then
          -- skip file size greater than 100k
          ret = false
        elseif bufname:match("^fugitive://") then
          -- skip fugitive buffer
          ret = false
        end
        return ret
      end,
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "kevinhwang91/nvim-bqf",
  enabled = config.enabled,
  ft = "qf",
  opts = config.opts,
}
