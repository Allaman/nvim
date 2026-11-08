local util = require("config.util")

vim.g.tmux_navigator_no_mappings = 1

util.pack("numToStr/Navigator.nvim")

local navigator = require("Navigator")

local mux_direction = { h = "left", j = "down", k = "up", l = "right" }

-- Rex panes: Navigator calls navigate() when you're already at nvim's outer edge.
local Rex = require("Navigator.mux.vi"):new()

function Rex:new()
  assert(vim.env.REX_BIN_DIR, "[Navigator] not running in Rex")
  self.__index = self
  return setmetatable({ rex = vim.env.REX_BIN_DIR .. "/rex" }, self)
end

function Rex:navigate(direction)
  if mux_direction[direction] then
    vim.system({ self.rex, "focus", mux_direction[direction] })
  end
  return self
end

local Herdr = require("Navigator.mux.vi"):new()

function Herdr:new()
  assert(vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "", "[Navigator] not running in herdr")
  self.__index = self
  local herdr = vim.env.HERDR_BIN_PATH
  return setmetatable({ herdr = (herdr and herdr ~= "") and herdr or "herdr" }, self)
end

function Herdr:navigate(direction)
  if mux_direction[direction] then
    vim.system({ self.herdr, "pane", "focus", "--direction", mux_direction[direction], "--current" })
  end
  return self
end

local function load_mux()
  for _, mux in ipairs({ Rex, Herdr, require("Navigator.mux.tmux") }) do
    local ok, instance = pcall(mux.new, mux)
    if ok then
      return instance
    end
  end
  return "auto"
end

navigator.setup({ mux = load_mux() })

vim.keymap.set("n", "<C-h>", navigator.left, {
  desc = "Navigate left",
})

vim.keymap.set("n", "<C-k>", navigator.up, {
  desc = "Navigate up",
})

vim.keymap.set("n", "<C-l>", navigator.right, {
  desc = "Navigate right",
})

vim.keymap.set("n", "<C-j>", navigator.down, {
  desc = "Navigate down",
})
