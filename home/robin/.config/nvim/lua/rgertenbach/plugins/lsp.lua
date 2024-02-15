return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        default = true,
        strict = true
      })
    end
  },

  "folke/trouble.nvim",  -- Diagnostics
  "folke/neodev.nvim",

  {
    "williamboman/nvim-lspconfig",
    dependencies = {
      -- LSP Setup
      {"williamboman/mason.nvim", config = true},
      "neovim/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },  -- Neovim config lsp
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
    },
  },
}

