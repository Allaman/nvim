-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.parse("gmail", "michaeljohannpeter@gmail.com", {}),
  env.parse("rootknecht", "allaman@rootknecht.net", {}),
  env.parse("mfg", "Mit freundlichen Grüßen\nMichael Peter", {}),
  env.parse("sehrg", "Sehr geehrte Damen und Herren, \n\n", {}),
  env.parse("modeline", "vim: foldmethod=marker", {}),
  env.s("date", env.p(os.date, "%Y-%m-%d")),
  env.s("time", env.p(os.date, "%H:%M")),
  env.s("htime", env.p(os.date, "%Y-%m-%dT%H:%M:%S+10:00")),
}
