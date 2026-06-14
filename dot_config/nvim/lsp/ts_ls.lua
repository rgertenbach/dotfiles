return {
  cmd = function(dispatchers, config)
    local cmd = 'typescript-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    local root_markers = {
      { "package-lock.json", "yarn.lock", "pnpm-lock.yaml" }, { ".git" }
    }
    on_dir(vim.fs.root(bufnr, root_markers) or vim.fn.getcwd())
  end,
  filetypes = { "javascript", "typescript" },
  settings = { implicitProjectConfiguration = { checkJs = true } }
}
