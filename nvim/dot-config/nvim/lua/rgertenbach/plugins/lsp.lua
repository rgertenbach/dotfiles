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

  {
    "folke/trouble.nvim", -- Diagnostics
    opts = {},
    cmd = "Trouble",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = function() require("lazydev").setup({}) end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Setup
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
    },
  },
}
