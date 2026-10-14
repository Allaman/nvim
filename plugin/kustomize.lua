local util = require("config.util")

util.pack("allaman/kustomize.nvim", { dev = true })

---@type KustomizeConfig
local opts = {
  enable_lua_snip = false,

  kinds = {
    auto_close = true,
    show_filepath = true,
    show_line = true,
  },

  run = {
    deprecations29 = {
      args = {
        "-t",
        "1.29",
        "-c=false",
        "--helm3=false",
        "-l=error",
        "-e",
        "-f",
      },
      cmd = "kubent",
    },

    deprecations30 = {
      args = {
        "-t",
        "1.30",
        "-c=false",
        "--helm3=false",
        "-l=error",
        "-e",
        "-f",
      },
      cmd = "kubent",
    },

    trivy = {
      args = { "-q", "fs" },
      cmd = "trivy",
    },
  },
}

require("kustomize").setup(opts)
