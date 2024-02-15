-- Luasnip utils

local ls = require("luasnip")
local t = ls.text_node
local f = ls.function_node

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

--- Simple backreference to another node.
---
---@param node integer The id of the node in the snippet.
---@return any 1 A copy of the output of the referenced node.
function m.ref(node)
  local function fn(args, _, _) return args[1][1] end
  return f(fn, node)
end

return m
