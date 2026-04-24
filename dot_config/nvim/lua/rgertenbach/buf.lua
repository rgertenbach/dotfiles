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

return m
