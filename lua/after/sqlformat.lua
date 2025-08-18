local embedded_sql = vim.treesitter.parse_query(
  'go',
  [[
	;SQL highlight injection for string literals
	(call_expression
	  function: (selector_expression
	    field: (field_identifier) @field
	    (#eq? @field "Prepare")
	  )
	
	  arguments: (argument_list
	    (raw_string_literal) @injection.content
	    (#set! injection.language "sql")
	  )
	)
  ]]
)

local root_node = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, 'go', {})
  local tree = parser:parse()[1]
  return tree:root()
end

local sqlformat = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= 'go' then
    return
  end

  local root = get_root(bufnr)

  local changes = {}
  for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
    local name = embedded_sql.captures[id]

    if name == 'sql' then
      local range = { node:range() }
      local indentation = string.rep(' ', range[2])

      local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

      for idx, line in ipairs(formatted) do
        formatted[idx] = indentation .. line
      end

      table.insert(changes, 1, { start = range[1] + 1, final = range[3], formatted = formatted })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
  end
end

-- vim.api.nvim_create_user_command('SQLFormat', function() sqlformat() end, {})
vim.api.nvim_command('command! SQLFormat lua sqlformat()')
