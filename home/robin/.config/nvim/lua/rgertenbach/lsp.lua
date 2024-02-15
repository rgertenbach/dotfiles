-- Set up of LSP via mason-lspconfig.

-- This doesn't include all servers, only overrides lspconig defaults.
local servers = {
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

---Generic on_attach all buffers should run.
---
---@param client lsp.Client
---@param bufnr number
local on_attach = function(client, bufnr)
  local via_telescope = require("telescope.builtin")
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  -- Diagnostics
  nmap("<leader>xx", "<Cmd>TroubleToggle<CR>", "Toggle Trouble window")
  nmap("<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>")
  nmap("<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>")
  nmap("<Leader>xl", "<Cmd>Trouble loclist<CR>")
  nmap("<Leader>xq", "<Cmd>Trouble quickfix<CR>")

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', via_telescope.lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', via_telescope.lsp_references, '[G]oto [R]eferences')
  nmap('gi', via_telescope.lsp_implementations, '[G]oto [I]mplementation')
  nmap('gt', via_telescope.lsp_type_definitions, '[T]ype Definition')
  nmap('<leader>ds', via_telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', via_telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Add `:Format` local to the LSP buffer
  if client.server_capabilities.documentFormattingProvider ~= nil then
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>==', vim.lsp.buf.format)
  end
end

-- Neodev *must* apparently be called before any other LSP setup.
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      settings = servers[server_name],
      on_attach = on_attach,
      filetypes = (servers[server_name] or {}).filetypes,
      capabilities = capabilities,
    })
  end,
})
