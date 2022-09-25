-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  -- s("date", p(os.date, "%Y-%m-%d")),
  env.s({ trig = "gwa", name = "Gitlab Warning" }, {
    env.t(":warning: "),
    env.i(1, { "some-warning" }),
  }),
  env.s({ trig = "hugoimg", name = "Hugo image shortcut" }, {
    env.t("{{< img name="),
    env.i(1, { "name" }),
    env.t(" lazy="),
    env.i(2, { "true" }),
    env.t(" >}}"),
  }),
  env.s({ trig = "hugotoc", name = "Hugo toc shortcut" }, {
    env.t("{{< toc >}}"),
  }),
  env.s({ trig = "hugosep", name = "Hugo intro separator shortcut" }, {
    env.t("<!-- more -->"),
  }),
  -- s(
  -- 	"hugores2",
  -- 	fmt(
  -- 		[[
  --      - name: {1}
  --        src: {2}.png
  --        title: {3}
  --    ]],
  -- 		{
  -- 			i(1, "name"),
  -- 			rep(1), -- repeat value 1 but "overjumps" it
  -- 			i(2, "title"),
  -- 		}
  -- 	)
  -- ),
  env.s({ trig = "hugores", name = "Hugo resource entry" }, {
    env.t("\t- name: "),
    env.i(1, { "name", "" }),
    env.t("\t\tsrc: "),
    -- use value of node 1 but do not "overjump" it
    env.d(2, function(args)
      return env.sn(nil, { env.i(1), env.i(1, args[1]) })
    end, { 1 }),
    env.t("\t\ttitle: "),
    env.i(3, { "title" }),
  }),
  env.s(
    "link",
    env.fmt(
      [[
      [{}]({}){}
      ]],
      {
        env.i(1, "name"),
        env.i(2, "url"),
        env.i(0),
      }
    )
  ),
}
