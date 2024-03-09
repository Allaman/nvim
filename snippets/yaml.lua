-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    "taskfile",
    env.fmt(
      [[
      version: "3"

      tasks:
        default:
          silent: true
          cmds:
            - task -l

        build:
          desc: Build
          cmds:
            - |
              echo building
              echo finished

        test:
          desc: Test
          deps:
            - build
          cmds:
            - defer: rm -r .build/
            - echo testing

        {}
      ]],
      {
        env.i(0),
      }
    )
  ),
}
