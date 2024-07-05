local utils = require("utils.functions")
local conf = vim.g.config.plugins
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
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
  dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert<cr>"),
  dashboard.button("f", "󰍉  Find File", ":" .. require("utils.functions").project_files() .. "<cr>"),
  dashboard.button("b", "  File Browser", ":" .. require("utils.functions").file_browser() .. "<cr>"),
  dashboard.button("s", "  Search String", "<cmd>Telescope live_grep<cr>"),
  dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("g", "  NeoGit", "<cmd>Neogit<cr>"),
  dashboard.button("l", "  Lazy", "<cmd>Lazy check<cr>"),
  dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.opts)
