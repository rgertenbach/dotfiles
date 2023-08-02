local lsp = require("lsp-zero").preset({
  manage_nvim_cmp = {
    documentation_window = true -- Show autocomplete
  }
})

-- Add keymaps only to supported buffers:
-- K: Hover information (documentation).
-- gd: Go to def
-- gD: Go to dec
-- gi: Go to impl
-- go: Go to type
-- gr: Go to Ref
-- gs: Display Signature
-- <F2>: Rename
-- gl: Display diagnostics
-- [d: Previous diag
-- ]d: Next diag
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })
end
)

-- Fix undefined global 'vim'
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      runtime = {
          -- version = "Lua 5.4",  -- Lua 5.4 for regular lua.
          version = "LuaJIT",  -- LuaJIT for NVIM.
      },
      diagnostics = {
        globals = { 'vim' }
      },
    }
  }
})

local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lua' }
  },
  mapping = {
    -- Enter key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + Space to trigger completion menu.
    ['<C-Space>'] = cmp.mapping.complete(),
  }
})

lsp.setup()
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>")
