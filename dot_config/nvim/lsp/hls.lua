return {
  cmd = { "haskell-language-server-wrapper", "--lsp", "--log-stderr", "False"},
  filetypes = { "haskell", "lhaskell", "cabal" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root_markers = { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml' }
    on_dir(vim.fs.root(fname, root_markers))
  end,
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
      cabalFormattingProvider = 'cabal-fmt',
      plugin = {
        semanticTokens = {
          globalOn = true
        }
      }
    },
  },
}
