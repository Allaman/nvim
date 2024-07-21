local utils = require("utils.functions")
local conf = vim.g.config.plugins
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

---Make a HTTP request to https://zenquotes.io to get a random quote
---@return string
local function get_quote()
  local found_curl, curl = pcall(require, "plenary.curl")
  if not found_curl then
    error("plenary not found")
    return ""
  end

  local response = curl.get("https://zenquotes.io/api/random", {
    headers = {
      ["User-Agent"] = "curl/7.68.0",
    },
  })

  if response.status ~= 200 then
    error("Http failed with " .. response.status, 1)
    return ""
  end

  local json_data = vim.json.decode(response.body, {})
  if json_data == {} or json_data == nil then
    error("empty json from quotes API decoded")
    return ""
  end

  return json_data[1].q
end

---set a specific or a random header
local function get_header()
  if utils.safe_nested_config(conf, "alpha", "header") then
    local headers = require("core.plugins.alpha.headers")
    if utils.get_nested_value(headers, conf.alpha.header) then
      return utils.get_nested_value(headers, conf.alpha.header)
    end
  end
  -- From https://gist.github.com/sRavioli/d6fb0a813b6affc171976b7dd09764d3
  return require("core.plugins.alpha.headers")["random"]
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = get_header()
dashboard.section.buttons.val = {
  dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert<cr>"),
  dashboard.button("f", "󰍉  Find File", ":" .. require("utils.functions").project_files() .. "<cr>"),
  dashboard.button("b", "  File Browser", ":" .. require("utils.functions").file_browser() .. "<cr>"),
  dashboard.button("s", "  Search String", "<cmd>Telescope live_grep<cr>"),
  dashboard.button("g", "  NeoGit", "<cmd>Neogit<cr>"),
  dashboard.button("l", "  Lazy", "<cmd>Lazy check<cr>"),
  dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end

-- default is not enabled because of lag from the http call
if conf.alpha.quote then
  -- Do not run when a file is directly opened from the command line
  -- and alpha is not even shown
  if vim.fn.argc(-1) == 0 then
    dashboard.section.footer.val = { get_quote() }
  end
end

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.opts)
