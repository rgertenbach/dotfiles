require('rgertenbach.colorbar').setup({default = 80})

vim.opt.timeout = false  -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.syntax = "on"  -- Enable Syntax Highlighting.
vim.opt.number = true  -- Show line numbers.
vim.opt.relativenumber = true  -- Show relative line numbers.
vim.opt.visualbell = true  -- No beep.
vim.opt.termguicolors = true -- 24-bit colors.
vim.opt.signcolumn = "yes"  -- Reserve space for diagnostic icons.
vim.opt.showmatch = true  -- Highlight matching brace.
vim.opt.splitright = true  -- Open vertical splits to the right.
vim.opt.splitbelow = true  -- Open horizontal splits below.


-- Indentation
vim.opt.expandtab = true  -- Spaces instead of tabs.
vim.opt.smartindent = true  -- Enable smart auto-indent.
vim.opt.shiftwidth = 2 -- # of auto indent spaces.
vim.opt.softtabstop = 2  -- Tab inserts two spaces.

-- Center after moving half pages.
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.opt.scrolloff = 8 -- Look at least 8 lines ahead.

-- Python
vim.g.python_recommended_style = 0  -- Disable automatic pep8-ing.
vim.g.python3_host_prog = '~/py/venv/bin/python3'

