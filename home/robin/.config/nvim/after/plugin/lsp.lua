vim.opt.signcolumn = "yes"  -- Reserve space for diagnostic icons.
local lsp = require("lsp-zero")

lsp.preset("recommended")

-- BS doesn't work
lsp.ensure_installed({
  "pyright",
  "bashls",
  "sumneko_lua",
})

-- Not supported in mason
require('lspconfig').ccls.setup{}  -- apt install ccls

lsp.nvim_workspace()  -- Support Nvim builtins

lsp.setup()
