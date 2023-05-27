return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  opts = {
    sections = {
      lualine_a = {},
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = true, -- Display new file status (new file means no write after created)
          path = 3, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
  config = true,
}
