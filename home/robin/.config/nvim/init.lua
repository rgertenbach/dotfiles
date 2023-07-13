require "remaps"
require "plugins"

-- Display options
vim.opt.encoding = "utf-8"
vim.opt.timeout = false  -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.syntax = "on"  -- Enable Syntax Highlighting
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.visualbell = true  -- No beep
vim.opt.ruler = true  -- Show row and column ruler information
vim.opt.scrolloff = 8  -- Look at least 8 lines ahead.
vim.opt.signcolumn = "yes"  -- Reserve space for diagnostic icons.
vim.o.termguicolors = true  -- Use 24bit
vim.fn.matchadd('ColorColumn', '\\%81v.\\+', -1)  -- Highlight if over 80 cols.

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

-- Editing
vim.opt.pastetoggle = "<F2>"  -- Allow pasting multiple line without auto-indent
vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"

-- netrw settings - don't use the tree (liststyle = 3), it's broken.
vim.g.netrw_banner = 0  -- Hide banner
vim.g.netrw_altv = 1  -- Split to the right with v
vim.g.netrw_winsize = 25  -- Quarter of the width
vim.g.netrw_keepdir = 0  -- Change current directory with the browsing dir.

-- Python autocmds
vim.g.python_recommended_style = 0  -- Disable automatic pep8-ing.
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufEnter"},
  {
    pattern = "*.py",
    callback = function() vim.makeprg = "/usr/bin/env python3 %<.py" end
  }
)
