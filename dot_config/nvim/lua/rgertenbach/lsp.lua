-- Set up of LSP via mason-lspconfig.

-- This doesn't include all servers, only overrides lspconig defaults.
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local M = {}


function M.make_capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
  return vim.tbl_deep_extend('force', client_capabilities, cmp_capabilities)
end

vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

---Generic on_attach all buffers should run.
---
---@param client vim.lsp.Client
---@param bufnr number
function M.on_attach(client, bufnr)
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

return M
