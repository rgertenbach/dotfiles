set nocompatible " be iMproved

" Other stuf
syntax on
set number " Show line numbers
set relativenumber " Show relative line numbers
set showmatch " Highlight matching brace
set visualbell " No beep
set ts=2 " Tab is two spaces

set hlsearch " Highlight all search results
set smartcase " smartcase
set incsearch " Searches for strings incrementally

set autoindent " Auto-indent new lines
set expandtab " Spaces instead of tabs
set shiftwidth=2 " Auto indent spaces
set smartindent " Enable smart-indent
set smarttab " Enable smart-tabs
set softtabstop=4 " Number of spaces per tab

set ruler " Show row and column ruler information

set undolevels=1000
set backspace=indent,eol,start

" Highlight if over 80 cols
call matchadd('ColorColumn', '\%81v', -1)

set clipboard=unnamedplus

set pastetoggle=<F2> " Allow pasting multiple line without auto-indent
