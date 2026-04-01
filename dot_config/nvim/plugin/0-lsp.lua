local function gh(repo)
  return "https://github.com/" .. repo .. ".git"
end

vim.pack.add({
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("mhartington/formatter.nvim"),
  gh("folke/trouble.nvim"),    -- Diagnostics cmd = "Trouble",
  gh("folke/lazydev.nvim"),    -- Better lua_ls.
  gh("neovim/nvim-lspconfig"), -- Prebuilt LSP Configs
})

require("mason").setup()
require("mason-lspconfig").setup()
require("lazydev").setup()

require("formatter").setup({
  filetype = {
    lua = { require("formatter.filetypes.lua").stylua },
    python = { require("formatter.filetypes.python").black },
    bash = { require("formatter.filetypes.sh").shfmt },
    -- Instead of autocmd
    -- "BufWritePre", { command = ":%s/\\s\\+$//e" }
    ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
  }
})
