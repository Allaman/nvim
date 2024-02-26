-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    { trig = "fl", name = "Println", desc = "Simple Println Snippet" },
    env.fmta(
      [[
      fmt.Println(<args>)
      <finish>
      ]],
      {
        args = env.i(1, "text"),
        finish = env.i(0),
      }
    )
  ),
  env.s(
    { trig = "fs", name = "Sprintf", desc = "Simple Sprintf Snippet" },
    env.fmta(
      [[
      fmt.Sprintf("<verbs>", <args>)
      <finish>
      ]],
      {
        verbs = env.i(1, "verbs"),
        args = env.i(2, "args"),
        finish = env.i(0),
      }
    )
  ),
}
