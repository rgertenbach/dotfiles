require "remaps"
require "plugins"

vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath=&runtimepath
]])


vim.opt.encoding = "utf-8"
vim.opt.timeout = false  -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.syntax = "on"  -- Enable Syntax Highlighting
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.visualbell = true  -- No beep

-- Search and replace
vim.opt.showmatch = true  -- Highlight matching brace
vim.opt.hlsearch = true  -- Highlight all search results
vim.opt.smartcase = true  -- smartcase
vim.opt.incsearch = true  -- Searches for strings incrementally

-- (Auto) indentation
vim.opt.autoindent = true  -- Auto-indent new lines
vim.opt.expandtab = true  -- Spaces instead of tabs
vim.opt.shiftwidth = 2 -- Auto indent spaces
vim.opt.smartindent = true  -- Enable smart-indent
vim.opt.smarttab = true  -- Enable smart-tabs
vim.opt.softtabstop = 2 -- Number of spaces per tab
vim.opt.tabstop = 2  -- Tab is two spaces

vim.opt.ruler = true  -- Show row and column ruler information

vim.opt.clipboard = "unnamedplus"
vim.opt.pastetoggle = "<F2>"  -- Allow pasting multiple line without auto-indent

vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')


-- Doesn't seem to work well in lua.
vim.cmd([[
call matchadd('ColorColumn', '\%81v', -1)  " Highlight if over 80 cols
]])


-- netrw settings - don't use the tree (liststyle = 3), it's broken.
vim.g.netrw_banner = 0  -- Hide banner
vim.g.netrw_altv = 1  -- Split to the right with v
vim.g.netrw_winsize = 25  -- Quarter of the width
vim.g.netrw_keepdir = 0  -- Change current directory with the browsing dir.


-- C-file autocmds
-- TODO: Make this apply ONLY to the c files, not non-c files opened after.
-- To do this I need to check what the language of the current buffer is when
-- it is activated.
vim.cmd([[
augroup vimrc_c
  autocmd!
  autocmd BufEnter *.c,*.h set cindent
  " autocmd BufNewFile *.c,*.h set makeprg=cc -o=%< -Wall -Wextra
  " autocmd BufLeave *.c,*.h set autoindent
augroup end
]])

-- Python autocmds
vim.g.python_recommended_style = 0  -- Disable automatic pep8-ing.
vim.cmd([[
augroup vimrc_py
  autocmd!
  " :make runs the current file with python3
  autocmd BufNewFile,BufEnter *.py set makeprg=/usr/bin/env\ python3\ %<.py"
augroup end
]])


