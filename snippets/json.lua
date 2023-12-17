-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = snip_env

return {
  env.s(
    "tasks",
    env.fmt(
      [===[
      {{
        "version": "2.0.0",
        "tasks": [
          {{
            "label": "Test Overseer",
            "type": "shell",
            "command": "ping -c 4 google.com",
            "group": "test",
            "presentation": {{
              "reveal": "always",
              "panel": "new"
            }}
          }}
        ]
      }}
      ]===],
      {}
    )
  ),
}
