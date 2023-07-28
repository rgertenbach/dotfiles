local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")  -- Self manage packer
  use("gabrielelana/vim-markdown") -- Markdown

  -- Fuzzy finder
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.2",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-tree/nvim-web-devicons"},
    }
  }
  use("sso://googler@user/vintharas/telescope-codesearch.nvim")

  -- Colorscheme
  use("EdenEast/nightfox.nvim")

  -- Syntax tree manager for syntax highlighting
  use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
  -- :TSPlaygroundToggle to browse the AST
  use("nvim-treesitter/playground")

  use("williamboman/mason.nvim")
  use("mbbill/undotree")

  -- LSP stuff
  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support, required.
      {"neovim/nvim-lspconfig"},

      -- Handles language servers.
      {
        "williamboman/mason.nvim",
        run = function() pcall(vim.cmd, 'MasonUpdate') end,
      },
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},  -- Required.
      {"hrsh7th/cmp-buffer"},  -- Is this the troublemaker?
      {"hrsh7th/cmp-nvim-lsp"},  -- Required
      {"hrsh7th/cmp-nvim-lua"},
      {"hrsh7th/cmp-path"},  -- To find files in pwd.
      {"saadparwaiz1/cmp_luasnip"},  -- Required.
      {"onsails/lspkind.nvim"},  -- Pictograms in autocomplete.

      -- Snippets
      {"L3MON4D3/LuaSnip"},
      {"rafamadriz/friendly-snippets"},

      -- LSP Diagnostics
      { "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons"}
    }
  }
end)
