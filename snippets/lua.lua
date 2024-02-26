-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    { trig = "pp", name = "pretty_print", desc = "Pretty Print" },
    env.fmta(
      [[
      vim.print(<args>)
      ]],
      {
        args = env.i(1, "args"),
      }
    )
  ),
}
