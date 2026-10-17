local M = {}

local DEV_ROOT = vim.fs.normalize(vim.fn.expand("~/workspace/github.com/allaman/"))

---@param repo string
---@return string
function M.gh(repo)
  return "https://github.com/" .. repo
end

---@param path string
---@param pattern string
local function source_runtime_files(path, pattern)
  for _, file in ipairs(vim.fn.globpath(path, pattern, false, true)) do
    vim.cmd.source(vim.fn.fnameescape(file))
  end
end

---@class PackOpts
---@field dev? boolean Use local development checkout instead of Git
---@field name? string Override the plugin/package name
---@field version? string|vim.VersionRange Git branch, tag, commit, or semver range

---@param repo string GitHub repository in `owner/repo` format
---@param opts? PackOpts
---@return string? path Local development path when `dev = true`
function M.pack(repo, opts)
  opts = opts or {}

  local name = opts.name or repo:match("/([^/]+)$")

  if not name then
    error("Could not determine plugin name from repository: " .. repo)
  end

  -- Local development checkout; fall back to Git when it's absent, e.g. in
  -- Docker builds where no dev workspaces exist
  if opts.dev then
    local path = vim.fs.joinpath(DEV_ROOT, name)

    if vim.uv.fs_stat(path) then
      -- Make Lua modules, autoload files, queries, ftplugins, etc. available.
      vim.opt.runtimepath:prepend(path)

      -- `after/` belongs at the end of runtimepath.
      local after = vim.fs.joinpath(path, "after")
      if vim.uv.fs_stat(after) then
        vim.opt.runtimepath:append(after)
      end

      -- Since this helper is called from files under `plugin/`, Neovim may
      -- already be in the plugin-loading phase. Merely modifying runtimepath
      -- doesn't guarantee this plugin's startup scripts are sourced.
      --
      -- Explicitly source them so commands, autocmds, etc. are registered.
      source_runtime_files(path, "plugin/**/*.{vim,lua}")

      -- Filetype detection scripts have the same issue when a plugin is added
      -- to runtimepath after filetype detection has already been initialized.
      source_runtime_files(path, "ftdetect/*.{vim,lua}")

      return path
    end
  end

  vim.pack.add({
    {
      src = M.gh(repo),
      name = name,
      version = opts.version,
    },
  })

  return nil
end

return M
