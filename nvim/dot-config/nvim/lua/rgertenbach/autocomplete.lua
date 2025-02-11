-- Autocomplete setup.

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.choice_active() then luasnip.change_choice(-1) end
end)
vim.keymap.set({ "i", "s" }, "<C-y>", function()
  if luasnip.choice_active() then luasnip.expand_or_jump() end
end)

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({select = true}),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
  },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 40,
      ellipsis_char = '⋯',
      show_labelDetails = true,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
      })
    }),
  }
})

