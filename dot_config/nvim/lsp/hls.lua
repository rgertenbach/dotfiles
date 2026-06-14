return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
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
    },
  },
  on_attach = function(_, bufnr)
    -- Cabal files don't support documentHighlight right now.
    if vim.bo.filetype == "cabal" then
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "LsPDocHighlight" })
    end
  end
}
