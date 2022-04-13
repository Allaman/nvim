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
	s(
		"kust",
		fmt(
			[[
      ---
      apiVersion: kustomize.config.k8s.io/v1beta1
      kind: Kustomization
      namespace: foo
      commonLabels:
        app.kubernetes.io/managed-by: kustomize
      commonAnnotations:
        foo: bar
      nameSuffix: foo
      resources:
        - {}
      patchesStrategicMerge:
        - {}
      {}
      ]],
			{
				i(1, "resources"),
				i(2, "patchesStrategicMerge"),
				i(0),
			}
		)
	),
	s(
		"kust_patch",
		fmt(
			[[
      patches:
        - target:
            group: {}
            version: {}
            kind: {}
          patch: |-
            - op: {}
              path: {}
              value: {}
      {}
      ]],
			{
				i(1, "group"),
				i(2, "version"),
				i(3, "kind"),
				i(4, "operation"),
				i(5, "path"),
				i(6, "value"),
				i(0),
			}
		)
	),
	s(
		"kust_img",
		fmt(
			[[
      images:
        - name: {}
          newName: {}
          newTag: {}
      {}
      ]],
			{
				i(1, "namge"),
				i(2, "newName"),
				i(3, "newTag"),
				i(0),
			}
		)
	),
	s(
		"kust_cm",
		fmt(
			[[
      configMapGenerator:
        - name: {}
          files:
            - {}
          options:
            labels:
              - foo: bar
      {}
      ]],
			{
				i(1, "name"),
				i(2, "file"),
				i(0),
			}
		)
	),
}
