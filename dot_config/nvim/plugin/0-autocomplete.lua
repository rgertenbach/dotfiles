local function gh(repo)
  return "https://github.com/" .. repo .. ".git"
end

vim.pack.add({
  gh("L3MON4D3/LuaSnip"),
	gh("hrsh7th/nvim-cmp"),
	gh("hrsh7th/cmp-buffer"),                  -- Find text in buffer.
  gh("hrsh7th/cmp-nvim-lsp"),                -- LSP.
  gh("hrsh7th/cmp-nvim-lsp-signature-help"), -- Signature info while typing.
  gh("hrsh7th/cmp-nvim-lua"),
  gh("hrsh7th/cmp-path"),                    -- To find files in pwd.
  gh("saadparwaiz1/cmp_luasnip"),            -- Integrate with cmp
  gh("onsails/lspkind.nvim"),                -- Pictograms in autocomplete.
})


local ls = require("luasnip")
vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

require "luasnip.loaders.from_lua".load({
  paths = {
    "~/.config/nvim/lua/rgertenbach/LuaSnip/"
  }
})

-- Autocomplete setup.
local cmp = require("cmp")

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then ls.change_choice(1) end
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then ls.change_choice(-1) end
end)
vim.keymap.set({ "i", "s" }, "<C-y>", function()
  if ls.choice_active() then ls.expand_or_jump() end
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
    expand = function(args) ls.lsp_expand(args.body) end
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = require('lspkind').cmp_format({
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
