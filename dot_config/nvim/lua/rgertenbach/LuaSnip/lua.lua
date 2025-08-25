local ls = require"luasnip"
local lu = require"rgertenbach.luasnip_util"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s(
  {
    trig = "snip",
    name = "Snippeo Boilerplate",
    dscr = "Boilerplate to add a new LuaSnip snippets file"
  },
  {
    t"local ls = require\"luasnip\"", lu.newline(),
    t"local lu = require\"rgertenbach.luasnip_util\"", lu.newline(),
    t"local s = ls.snippet", lu.newline(),
    t"local t = ls.text_node", lu.newline(),
    t"local i = ls.insert_node", lu.newline(2),
    t"return {", lu.newline(),
    t"  s(", lu.newline(),
    t"  {", lu.newline(),
    t"    trig = \"", i(1, "snip"), t"\",", lu.newline(),
    t"    name = \"", i(2, "Name"), t"\",", lu.newline(),
    t"    dscr = \"", i(3, "Description"), t"\",", lu.newline(),
    t"  },", lu.newline(),
    t"  {", lu.newline(),
    t"    ", i(0), lu.newline(),
    t"  }", lu.newline(),
    t"  ),", lu.newline(),
    t"}", lu.newline(),
  }
  ),
}
