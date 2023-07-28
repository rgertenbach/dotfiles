local colorbar = require('rgertenbach.colorbar')

vim.g.python3_host_prog = '~/py/venv/bin/python3'

vim.opt.encoding = "utf-8"
vim.opt.timeout = false  -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.syntax = "on"  -- Enable Syntax Highlighting
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.visualbell = true  -- No beep
vim.opt.termguicolors = true -- 24bit colors
vim.opt.signcolumn = "yes"  -- Reserve space for diagnostic icons.

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

vim.opt.pastetoggle = "<F2>"  -- Allow pasting multiple line without auto-indent

vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"

-- Center after moving half pages.
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.opt.scrolloff = 8 -- Look at least 8 lines ahead.

colorbar.setup({
  default = 80,
  mapping = {
      sql = 100,
      googlesql = 100
  }
})

-- netrw settings
vim.g.netrw_banner = 0  -- Hide banner
vim.g.netrw_altv = 1  -- Split to the right with v
vim.g.netrw_winsize = 25  -- Quarter of the width
vim.g.netrw_chgwin = -1  -- Open in leftmost non-netrw buffer with enter.

-- Python autocmds
vim.g.python_recommended_style = 0  -- Disable automatic pep8-ing.
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufEnter"},
  {
    pattern = "*.py",
    callback = function() vim.makeprg = "/usr/bin/env python3 %<.py" end
  }
)

