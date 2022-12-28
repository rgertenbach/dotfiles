vim.cmd([[
augroup netrw_mapping
autocmd!
" Move back to the previous window when closing netrw with <C-c>.
autocmd filetype netrw noremap <buffer> <C-c> :bd<Enter>
autocmd filetype netrw noremap <buffer> <leader>e :bd<Enter>
augroup end
]])
