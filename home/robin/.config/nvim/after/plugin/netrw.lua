vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "netrw",
    desc = "Allow closing of netrw",
    callback = function()
      vim.keymap.set("n", "<C-c>", ":bd<Enter>", { buffer = 0 })
      vim.keymap.set("n", "<leader>e", ":bd<Enter>", { buffer = 0 })
    end,
    group = vim.api.nvim_create_augroup("NetrwMapping", { clear = true })
  }
)
