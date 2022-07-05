-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    "kust",
    env.fmt(
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
        env.i(1, "resources"),
        env.i(2, "patchesStrategicMerge"),
        env.i(0),
      }
    )
  ),
  env.s(
    "kust_patch",
    env.fmt(
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
        env.i(1, "group"),
        env.i(2, "version"),
        env.i(3, "kind"),
        env.i(4, "operation"),
        env.i(5, "path"),
        env.i(6, "value"),
        env.i(0),
      }
    )
  ),
  env.s(
    "kust_img",
    env.fmt(
      [[
      images:
        - name: {}
          newName: {}
          newTag: {}
      {}
      ]],
      {
        env.i(1, "namge"),
        env.i(2, "newName"),
        env.i(3, "newTag"),
        env.i(0),
      }
    )
  ),
  env.s(
    "kust_cm",
    env.fmt(
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
        env.i(1, "name"),
        env.i(2, "file"),
        env.i(0),
      }
    )
  ),
}
