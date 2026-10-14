---@type vim.lsp.Config
return {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_markers = { ".taplo.toml", "taplo.toml", ".git" },
  settings = {
    taplo = {
      schema = {
        associations = {
          [".*sesh\\.toml$"] = "https://github.com/joshmedeski/sesh/raw/main/sesh.schema.json",
        },
      },
    },
  },
}
