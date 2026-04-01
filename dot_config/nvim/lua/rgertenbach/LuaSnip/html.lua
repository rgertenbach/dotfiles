local ls = require "luasnip"
local lu = require "rgertenbach.luasnip_util"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
  s(
    {
      trig = "tag",
      name = "HTML Tag",
      dscr = "HTML Tag and its closing tag",
    },
    {
      t "<", i(1, "tag"), t ">", i(0), t "</", rep(1), t ">",
    })
}
