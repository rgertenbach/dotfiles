-- Bootstrap Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Must be set before lazy is set up.
vim.g.mapleader = ' '  -- <Leader>
vim.g.maplocalleader = ' '  -- <LocalLeader>

-- Configure PDE
-- Set up to load rgertenbach first and adds extras after.
-- Load plugins *before* config as many depend on or set up the plugins.

-- Plugins
require("lazy").setup({
  {import = "rgertenbach.plugins"},
}, {})

-- Config
require("rgertenbach")
