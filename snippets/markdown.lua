-- require("luasnip.loaders.from_lua").lazy_load()
local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local t = require("luasnip.nodes.textNode").T
local f = require("luasnip.nodes.functionNode").F
local i = require("luasnip.nodes.insertNode").I
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local parse = require("luasnip.util.parser").parse_snippet
local ai = require("luasnip.nodes.absolute_indexer")

return {
	-- s("date", p(os.date, "%Y-%m-%d")),
	s({ trig = "gwa", name = "Gitlab Warning" }, {
		t(":warning: "),
		i(1, { "some-warning" }),
	}),
	s({ trig = "hugoimg", name = "Hugo image shortcut" }, {
		t("{{< img name="),
		i(1, { "name" }),
		t(" lazy="),
		i(2, { "true" }),
		t(" >}}"),
	}),
	s({ trig = "hugotoc", name = "Hugo toc shortcut" }, {
		t("{{< toc >}}"),
	}),
	s({ trig = "hugosep", name = "Hugo intro separator shortcut" }, {
		t("<!-- more -->"),
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
	s({ trig = "hugores", name = "Hugo resource entry" }, {
		t("\t- name: "),
		i(1, { "name", "" }),
		t("\t\tsrc: "),
		-- use value of node 1 but do not "overjump" it
		d(2, function(args)
			return sn(nil, { i(1), i(1, args[1]) })
		end, { 1 }),
		t("\t\ttitle: "),
		i(3, { "title" }),
	}),
	s(
		"link",
		fmt(
			[[
      [{}]({})
      ]],
			{
				i(1, "name"),
				i(2, "url"),
			}
		)
	),
}
