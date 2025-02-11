return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

      require"luasnip.loaders.from_lua".load({paths = {
        "~/.config/nvim/lua/rgertenbach/LuaSnip/"
      }})

    end
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",  -- Find text in buffer.
      "hrsh7th/cmp-nvim-lsp",  -- LSP.
      "hrsh7th/cmp-nvim-lsp-signature-help",  -- Signature info while typing.
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",  -- To find files in pwd.
      -- Integrates snippets.
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          "L3MON4D3/LuaSnip",  -- Snippets engine
        },
      },
      "onsails/lspkind.nvim",  -- Pictograms in autocomplete.
    },
  },
}
