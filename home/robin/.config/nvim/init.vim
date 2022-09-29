set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'  " Autocomplete
call plug#end()

" lua require'plugins'

" npm -g install pyright
lua require'lspconfig'.pyright.setup{}  

" apt install ccls
lua require'lspconfig'.ccls.setup{}

