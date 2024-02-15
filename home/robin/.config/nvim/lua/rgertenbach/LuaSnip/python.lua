local ls = require"luasnip"
local lu = require"rgertenbach.luasnip_util"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s(
  {
    trig = "main",
    name = "Main def and entry",
    dscr = "Boilerplate defining and calling main. Keeps a script's functions importable"
  },
  {
    t"def main() -> None:", lu.newline(),
    t"  ", i(0), lu.newline(3),
    t"if __name__ == '__main__':", lu.newline(),
    t"  main()"
  }
  ),
}
