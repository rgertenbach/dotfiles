-- Set up of LSP via mason-lspconfig.

-- This doesn't include all servers, only overrides lspconig defaults.
local cmp_nvim_lsp = require('cmp_nvim_lsp')


local M = {}

M.servers = {
  lua_ls = {
    Lua = {
      runtime = {
        -- version = "Lua 5.4",  -- Lua 5.4 for regular lua.
        version = "LuaJIT", -- LuaJIT for NVIM.
      },
      diagnostics = {
        globals = { 'vim' }
      },
    },
  },
}

vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

---Generic on_attach all buffers should run.
---
---@param client vim.lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
  local via_telescope = require("telescope.builtin")
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  -- Diagnostics
  -- <C-w>d opens diagnostics in a window
  nmap("<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", "Toggle Trouble window")

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', via_telescope.lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', via_telescope.lsp_references, '[G]oto [R]eferences')
  nmap('gi', via_telescope.lsp_implementations, '[G]oto [I]mplementation')
  nmap('gt', via_telescope.lsp_type_definitions, '[G]oto [T]ype Definition')
  nmap('<leader>ds', via_telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', via_telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

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

function M.make_capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
  return vim.tbl_deep_extend('force', client_capabilities, cmp_capabilities)
end

return M
