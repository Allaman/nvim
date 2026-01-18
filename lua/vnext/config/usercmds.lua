vim.api.nvim_create_user_command("IPCalc", function(opts)
  local word

  -- Check if called from visual mode
  if opts.range > 0 then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    -- Handle single line selection
    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
      -- Multi-line selection (take first line for now)
      lines[1] = string.sub(lines[1], start_pos[3])
    end

    word = lines[1]
  else
    -- Get the WORD under the cursor (includes special chars like /)
    word = vim.fn.expand("<cWORD>")
  end

  -- Check if the word looks like an IP address with optional CIDR notation
  -- Matches: 192.168.1.1 or 192.168.1.0/24
  if not word:match("^%d+%.%d+%.%d+%.%d+/?%d*$") then
    vim.notify("No valid IP address under cursor or selected", vim.log.levels.WARN)
    return
  end

  local output = vim.fn.system("ipcalc " .. vim.fn.shellescape(word))

  if vim.v.shell_error ~= 0 then
    vim.notify("ipcalc command failed", vim.log.levels.ERROR)
    return
  end

  -- Display output in a floating window
  local lines = vim.split(output, "\n")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 80
  local height = 10
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " ipcalc: " .. word .. " ",
    title_pos = "center",
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { nowait = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { nowait = true })
end, {
  range = true, -- Enable range support
  desc = "Run ipcalc on IP address under cursor or visual selection",
})

local function get_yaml_path()
  -- Check if treesitter is available
  local has_treesitter, _ = pcall(require, "nvim-treesitter")
  if not has_treesitter then
    vim.notify("nvim-treesitter not found", vim.log.levels.ERROR)
    return nil
  end

  -- Get the parser for the current buffer
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "yaml")
  if not ok then
    vim.notify("YAML treesitter parser not found. Install with :TSInstall yaml", vim.log.levels.ERROR)
    return nil
  end

  -- Get cursor position
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  -- Get the syntax tree
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Get the node at cursor
  local node = root:descendant_for_range(row, col, row, col)
  if not node then
    vim.notify("No node found at cursor", vim.log.levels.WARN)
    return nil
  end

  local path_parts = {}
  local current = node

  -- Traverse up the tree to build the path
  while current do
    local type = current:type()

    -- Handle different YAML node types
    if type == "block_mapping_pair" then
      -- Get the key node (first child)
      local key_node = current:child(0)
      if key_node then
        local key_text = vim.treesitter.get_node_text(key_node, 0)
        -- Remove quotes and colons if present
        key_text = key_text:gsub("^[\"']", ""):gsub("[\"']$", ""):gsub(":$", "")
        table.insert(path_parts, 1, key_text)
      end
    elseif type == "block_sequence_item" then
      -- Handle array indices
      local parent = current:parent()
      if parent and parent:type() == "block_sequence" then
        local index = 0
        for child in parent:iter_children() do
          if child == current then
            break
          end
          if child:type() == "block_sequence_item" then
            index = index + 1
          end
        end
        table.insert(path_parts, 1, "[" .. index .. "]")
      end
    end

    current = current:parent()
  end

  if #path_parts == 0 then
    return nil
  end

  return table.concat(path_parts, ".")
end

-- Create the user command
vim.api.nvim_create_user_command("YamlCopyPath", function()
  local path = get_yaml_path()
  if path then
    vim.fn.setreg("+", path)
    vim.notify("Copied to clipboard: " .. path, vim.log.levels.INFO)
  else
    vim.notify("Could not determine YAML path", vim.log.levels.WARN)
  end
end, {})
