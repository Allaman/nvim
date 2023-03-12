-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    "ff",
    env.fmt(
      [[
      fmt.Println({})
      ]],
      {
        env.i(1, "text"),
      }
    )
  ),
  env.s(
    "fff",
    env.fmt(
      [[
      fmt.Printf({})
      ]],
      {
        env.i(1, "text"),
      }
    )
  ),
  env.s(
    "sf",
    env.fmt(
      [[
      fmt.Sprintf({})
      ]],
      {
        env.i(1, "text"),
      }
    )
  ),
}
