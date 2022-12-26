-- Move back to the previous window when closing netrw with <C-c>.
vim.cmd([[
augroup netrw_mapping
autocmd!
autocmd filetype netrw noremap <buffer> <C-c> :bd<Enter>
augroup end
]])

