local m = {}

--- Convert word under cursor from CamelCase to snake_case.
function m.camel_to_snake()
  local word = vim.call('expand', '<cword>')
  local out = word:gsub("(%u)", "_%1"):gsub("(%u)", string.lower):gsub("^_", "")
  vim.cmd("normal! ciw" .. out)
end

--- Convert word under cursor from snake_case to CamelCase.
function m.snake_to_camel()
  local word = vim.call('expand', '<cword>')
  local out = word:gsub("_(.)", string.upper):gsub("^(.)", string.upper)
  vim.cmd("normal! ciw" .. out)
end

--- Switch word under cursor between snake_case and CamelCase.
function m.toggle_snake_camel()
  local word = vim.call('expand', '<cword>')
  if word:match("_") then
    m.snake_to_camel()
  else
    m.camel_to_snake()
  end
end

--- Aligns lines by the first occurrence of the regex.
---@param command vim.api.keyset.create_user_command.command_args
---@param out_buf integer
---@return integer 1 Return code for preview handling.
function m.align_buffer(command, ns, out_buf)
  local in_buf = vim.api.nvim_get_current_buf()
  if out_buf == nil then out_buf = in_buf end
  local first = command.line1
  local last = command.line2
  if first == last then
    first = 1
    last = vim.fn.line("$")
  end
  local regex = vim.regex(command.args)
  local rightmost = 0
  local position = {}
  for ln = first, last do
    local col = regex:match_line(in_buf, ln - 1)
    if col ~= nil then
      position[ln - 1] = col
      rightmost = math.max(rightmost, col)
    end
  end
  for ln, col in pairs(position) do
    local len = rightmost - col
    if len > 0 then
      local spaces = { string.rep(" ", len) }
      vim.api.nvim_buf_set_text(out_buf, ln, col, ln, col, spaces)
      if ns then
        vim.hl.range(out_buf, ns, "Substitute", { ln, col }, { ln, col + len })
      end
    end
  end
  return 1
end

---@param x integer The number to round
---@param digits integer The number of decimal digits to round to.
function m.round(x, digits)
	local pow = 10 ^ (digits or 0)
	return math.floor(x * pow + 0.5) / pow
end

---@param line string The string to search.
---@param pattern string The pattern to match.
---@param col integer 1-based column that needs to be included in the match.
---@return string | nil, integer | nil, integer | nil
function m.match_left(line, pattern, col)
	local pat = "(" .. pattern .. ")"
	local start, end_, captured
	for init = 0, math.min(#line - 1, col) do
		start, end_, captured = line:find(pat, init)
		if start and start <= col and col <= end_ then
			return captured, start, end_
		end
	end
	return nil, nil, nil
end

---@param line string The string to search.
---@param pattern string The pattern to match.
---@param col integer 1-based column that needs to be included in the match.
---@return string | nil, integer | nil, integer | nil
function m.match_right(line, pattern, col)
	local pat = "(" .. pattern .. ")"
	local start, end_, captured
	for init = math.min(#line - 1, col), 1, -1 do
		start, end_, captured = line:find(pat, init)
		if start and start <= col and col <= end_ then
			return captured, start, end_
		end
	end
	return nil, nil, nil
end

---@param pattern string
---@param bias "left" | "right"
---@return string | nil, integer | nil, integer | nil, integer | nil
function m.cpattern(pattern, bias)
	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1] - 1, pos[2]
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, true)[1]
	local match, start, end_
	if bias == "left" then
		match, start, end_ = m.match_left(line, pattern, col + 1)
		return match, match and row, start, end_
	else
		match, start, end_ = m.match_right(line, pattern, col + 1)
		return match, match and row, start, end_
	end
end

vim.api.nvim_create_user_command("Round", function(opts)
	local match, row, col, end_ = m.cpattern("%d*%.%d*", "left")
	if match == nil or row == nil or end_ == nil then
		vim.print("couldn't find number")
		return
	end
	local number = tonumber(match)
	if number == nil then
		vim.print("couldn't parse number")
		return
	end
	local digits = tonumber(opts.args) or 0
	local rounded = m.round(number, digits)
	local formatted = ("%%.%df"):format(math.max(digits, 0)):format(rounded)
	vim.api.nvim_buf_set_text(0, row, col - 1, row, end_, { formatted })
end, { nargs = "?" })


return m
