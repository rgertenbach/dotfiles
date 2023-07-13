set nocompatible " be iMproved

syntax on " Enable Syntax Highlighting
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

set pastetoggle=<F2> " Allow pasting multiple line without auto-indent

" C-file autocmds
" TODO: Make this apply ONLY to the c files, not non-c files opened after.
" To do this I need to check what the language of the current buffer is when
" it is activated.
augroup vimrc_c
  autocmd!
  autocmd BufEnter *.c,*.h set cindent
  " autocmd BufNewFile *.c,*.h set makeprg=cc -o=%< -Wall -Wextra
  " autocmd BufLeave *.c,*.h set autoindent
augroup end

" Python autocmds
let g:python_recommended_style = 0 " Disable automatic pep8-ing.
augroup vimrc_py
  autocmd!
  " :make runs the current file with python3
  autocmd BufNewFile,BufEnter *.py set makeprg=/usr/bin/env\ python3\ %<.py"
augroup end
