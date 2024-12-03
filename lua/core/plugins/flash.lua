-- NOTE: https://github.com/folke/flash.nvim/commit/2411de6fd773ab5b902cf04f2dccfe3baadff229
return {
  "folke/flash.nvim",
  opts = {},
  keys = {
    {
      "ss",
      mode = { "n", "x", "o" },
      -- Jump to any word
      function()
        require("flash").jump({
          pattern = ".", -- initialize pattern with any char
          search = {
            mode = function(pattern)
              -- remove leading dot
              if pattern:sub(1, 1) == "." then
                pattern = pattern:sub(2)
              end
              -- return word pattern and proper skip pattern
              return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
            end,
          },
        })
      end,
      desc = "Flash",
    },
    {
      "<cr>", -- TODO: better mapping
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
  },
}
