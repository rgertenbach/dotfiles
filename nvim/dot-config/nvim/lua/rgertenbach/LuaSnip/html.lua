local ls = require "luasnip"
local lu = require "rgertenbach.luasnip_util"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s(
    {
      trig = "tag",
      name = "HTML Tag",
      dscr = "HTML Tag and its closing tag",
    },
    {
      t "<", i(1, "tag"), t ">", i(0), t "</", lu.ref(1), t ">",
    })
}
