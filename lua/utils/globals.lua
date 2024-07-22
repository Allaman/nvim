-- Print the string representation of a Lua table
P = function(v)
  vim.print(vim.inspect(v))
  return v
end

-- Print config
PC = function()
  vim.print(vim.g.config)
end

-- Reload a plugin with Lazy
LR = function(name)
  vim.api.nvim_command("Lazy reload " .. name)
end
