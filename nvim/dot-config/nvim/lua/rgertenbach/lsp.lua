-- Set up of LSP via mason-lspconfig.

-- This doesn't include all servers, only overrides lspconig defaults.
local cmp_nvim_lsp = require('cmp_nvim_lsp')


local function make_capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
  return vim.tbl_deep_extend('force', client_capabilities, cmp_capabilities)
end

local servers = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME }
        }
      })
    end,
    capabilities = make_capabilities(),
    settings = { Lua = {} },
  },
  bashls = {},
  clangd = {},
  pyright = {},
  hls = { filetypes = { "haskell", "lhaskell", "cabal" } },
}

vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

---Generic on_attach all buffers should run.
---
---@param client vim.lsp.Client
---@param bufnr number
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  -- Diagnostics
  -- <C-w>d opens diagnostics in a window
  nmap("<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", "Toggle Trouble window")
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')

  -- Add `:LspFormat` local to the LSP buffer
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>==', vim.lsp.buf.format)
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd(
      { "CursorHold", "CursorHoldI" },
      {
        buffer = bufnr,
        group = "LspDocumentHighlight",
        callback = vim.lsp.buf.document_highlight,
      })
    vim.api.nvim_create_autocmd(
      { "CursorMoved" },
      {
        buffer = bufnr,
        group = "LspDocumentHighlight",
        callback = vim.lsp.buf.clear_references,
      })
  end
end

for lang, conf in pairs(servers) do
  local base_config = { on_attach = on_attach }
  vim.lsp.config(lang, vim.tbl_deep_extend("force", base_config, conf or {}))
  vim.lsp.enable(lang)
end
