set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" lua require'plugins'

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'  " Autocomplete
call plug#end()

lua require'lspconfig'.pyright.setup{}
