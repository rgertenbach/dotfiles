local use = require('packer').use
require('packer').startup(function()
  use('wbthomason/packer.nvim')  -- Package manager
  use('neovim/nvim-lspconfig')  -- Collection of configurations for the built-in LSP client
  -- use('hrsh7th/cmp-nvim-lsp')  -- Autocomplete
  use('hrsh7th/nvim-cmp')  -- Autocomplete
end)
