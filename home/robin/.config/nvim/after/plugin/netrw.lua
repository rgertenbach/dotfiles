--[[vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "netrw",
    callback = function()
      vim.keymap.set("n", "<C-c>", ":bd<Enter>")
      vim.keymap.set("n", "<leader>e", ":bd<Enter>")
    end,
    group = vim.api.nvim_create_augroup("NetrwMapping", { clear = true })
  }
)]]
vim.cmd([[
augroup netrw_mapping
autocmd!
" Move back to the previous window when closing netrw with <C-c>.
autocmd filetype netrw noremap <buffer> <C-c> :bd<Enter>
autocmd filetype netrw noremap <buffer> <leader>e :bd<Enter>
augroup end
]])
