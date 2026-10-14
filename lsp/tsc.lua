local bin_cache = {} ---@type table<string, string>

--- Checks if the given tsc/tsgo cmd supports the "--lsp" arg.
---@param bin string
---@return boolean
local function supports_lsp(bin)
  if vim.fn.executable(bin) ~= 1 then
    return false
  end

  local out = vim.system({ bin, "--version" }, { text = true }):wait()
  local version = vim.version.parse(out.stdout or "")

  return out.code == 0 and version ~= nil and version.major >= 7
end

---@type vim.lsp.Config
return {
  settings = {
    ["js/ts"] = {
      inlayHints = {
        parameterNames = {
          enabled = "literals",
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      implementationsCodeLens = {
        enabled = true,
        showOnInterfaceMethods = true,
        showOnAllClassMethods = true,
      },
    },
  },
  cmd = function(dispatchers, config)
    local cmd = bin_cache[(config or {}).root_dir] or "tsc"
    return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
      or vim.list_extend(root_markers, { ".git" })

    local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
    local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
    local project_root = vim.fs.root(bufnr, root_markers)
    if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
      -- deno lock is closer than package manager lock, abort
      return
    end
    if deno_root and (not project_root or #deno_root >= #project_root) then
      -- deno config is closer than or equal to package manager lock, abort
      return
    end
    -- project is standard TS, not deno
    -- We fallback to the current working directory if no project root is found
    local root = project_root or vim.fn.getcwd()

    if bin_cache[root] then
      return on_dir(root)
    end

    local bins = {}

    for _, bin in ipairs({ "tsc", "tsgo" }) do
      bins[#bins + 1] = vim.fs.joinpath(root, "node_modules/.bin", bin)
      bins[#bins + 1] = bin
    end

    for _, bin in ipairs(bins) do
      if supports_lsp(bin) then
        bin_cache[root] = bin
        return on_dir(root)
      end
    end

    vim.notify("tsc: no binary supporting `--lsp` found (requires TypeScript 7.0+)", vim.log.levels.WARN)
  end,
}
