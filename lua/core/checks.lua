local utils = require("core.utils.functions")

local required_programs = {
  go = "Some Go related features might not work",
  node = "Mason will not be able to install some LSPs/tools",
  python3 = "Some Python related features might not work",
  cargo = "Some Rust related features might not work",
  trash = "Neo-tree requires 'trash-cli' to be able to move files to the trash",
  tectonic = "Latex build command will not work",
  rg = "a highly recommended grep alternative (ripgrep is the package name)",
  fd = "a highly recommended find alternative",
}

local function checkRequirement(command, msg)
  if not utils.isExecutableAvailable(command) then
    utils.notify(
      string.format("Missing %s binary or not found in PATH - %s", command, msg),
      vim.log.levels.WARN,
      "core.checks"
    )
  end
end

for k, v in pairs(required_programs) do
  checkRequirement(k, v)
end

if not utils.isNeovimVersionsatisfied(9) then
  utils.notify(
    string.format("This config probably won't work very well with Neovim < 0.9"),
    vim.log.levels.WARN,
    "core.checks"
  )
end
