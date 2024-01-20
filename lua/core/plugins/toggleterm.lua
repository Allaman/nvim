local M = {
  "akinsho/nvim-toggleterm.lua",
  keys = "<C-n>",
  config = function()
    local map = vim.api.nvim_set_keymap
    local buf_map = vim.api.nvim_buf_set_keymap

    require("toggleterm").setup({
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = "<C-n>",
      shading_factor = "1", -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
      direction = "vertical", -- 'vertical' | 'horizontal' | 'window' | 'float',
    })

    local opts = { noremap = true }
    map("t", "<ESC>", "<C-\\><C-n>", opts) -- back to normal mode in Terminal

    -- Better navigation to and from terminal
    local set_terminal_keymaps = function()
      buf_map(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      buf_map(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      buf_map(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      buf_map(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      buf_map(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end
    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
        vim.cmd([[setlocal nospell]])
      end,
      desc = "Mappings for navigation with a terminal",
    })
  end,
}

return M
