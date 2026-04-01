-- Luasnip utils

local ls = require("luasnip")
local t = ls.text_node

local m = {}

--- Insert linebreaks.
---
---@param n integer | nil The number of linebreaks, defaults to 1.
---@return any 1 A textnode.
function m.newline(n)
  n = n or 1
  local newlines = {""}
  for _ = 1, n do table.insert(newlines, "") end
  return t(newlines)
end

return m
