local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  RELOADER = require
else
  RELOADER = plenary_reload.reload_module
end

RELOAD = function(...)
  return RELOADER(...)
end

-- Reload a module
R = function(name)
  RELOAD(name)
  return require(name)
end

-- Print the string representation of a Lua table
P = function(v)
  print(vim.inspect(v))
  return v
end
