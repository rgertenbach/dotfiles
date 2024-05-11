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

vim.opt.pastetoggle = "<F2>"  -- To paste multiple line without auto-indent.

-- Center after moving half pages.
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.opt.scrolloff = 8 -- Look at least 8 lines ahead.

-- netrw settings
vim.g.netrw_banner = 0  -- Hide banner.
vim.g.netrw_altv = 1  -- Split to the right with v.
vim.g.netrw_winsize = 25  -- Quarter of the width.
vim.g.netrw_chgwin = -1  -- Open in leftmost non-netrw buffer with enter..

vim.api.nvim_create_augroup("netrw_mapping", {})

-- Close netrw with Ctrl+c
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = "netrw",
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "", "<C-c>", ":bd<CR>", {})
    end,
    group = "netrw_mapping",
  }
)

-- Python
vim.g.python_recommended_style = 0  -- Disable automatic pep8-ing.
vim.g.python3_host_prog = '~/py/venv/bin/python3'

