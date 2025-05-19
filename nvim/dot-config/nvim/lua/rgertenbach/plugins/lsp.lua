local rg_lsp = require("rgertenbach.lsp")

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
    "folke/trouble.nvim",  -- Diagnostics
    opts = {},
    cmd = "Trouble",
  },
  "folke/neodev.nvim",

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Setup
      {"williamboman/mason.nvim", config = true},
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },  -- Neovim config lsp
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
    },
    config = function()

      -- Neodev *must* apparently be called before any other LSP setup.
      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities beyond nvim's.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities(capabilities))

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(rg_lsp.servers),
	handlers = {
	  function(server_name)
	    require('lspconfig')[server_name].setup({
	      settings = rg_lsp.servers[server_name],
	      on_attach = rg_lsp.on_attach,
	      filetypes = (rg_lsp.servers[server_name] or {}).filetypes,
	      capabilities = rg_lsp.make_capabilities(),
	    })
	  end,
	}
      })
    end
  },
}

