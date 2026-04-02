local function gh(repo)
  return "https://github.com/" .. repo .. ".git"
end

vim.pack.add({
  gh("EdenEast/nightfox.nvim"),      -- Colorscheme
  gh("mbbill/undotree"),
  gh("rgertenbach/ToRepl.nvim"),     -- Execute buffer.
  gh("echasnovski/mini.statusline"), -- Better statusline.
  gh("echasnovski/mini.move"),       -- Move selection with <M-[hjkl]>.
  gh("nvim-mini/mini.icons"),        -- Cooler icons.
  gh("stevearc/oil.nvim"),           -- Manage files in buffer.

  -- gh("nvim-telescope/telescope-fzf-native.nvim"),  -- Need cmake update hook
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-lua/plenary.nvim"), -- Dep for Treesitter
  gh("nvim-telescope/telescope-file-browser.nvim"),
  gh("nvim-tree/nvim-web-devicons"), -- File type icons.
})

vim.cmd.colorscheme("nightfox")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
require("mini.statusline").setup()
require("mini.move").setup()
require("mini.icons").setup()

require("oil").setup({
  columns = { "icon", "permissions", "size", "mtime" },
  view_options = { show_hidden = true, },
})
vim.keymap.set("n", "<leader>-", require("oil").open)
vim.keymap.set("n", "<leader>v-", function()
  vim.cmd.vsplit()
  require("oil").open()
end)
vim.keymap.set("n", "<leader>s-", function()
  vim.cmd.split()
  require("oil").open()
end)

local torepl = require("torepl")
torepl.setup({
  commands = {
    python = {
      cmd = "~/py/venv/bin/ipython \"%s\" -i",
      delimiter = "# PRE",
      pass_as = torepl.PassMethod.file
    },
    csv = {
      cmd = "~/py/venv/bin/ipython ~/py/csv_loader.py \"%s\"",
      pass_as = torepl.PassMethod.file,
    },
    lua = {
      cmd = "lua -i \"%s\"",
      pass_as = torepl.PassMethod.file,
      after = "os.remove(arg[0])",
      delimiter = "-- PRE",
    },
  },
})
vim.keymap.set("n", "<leader><CR>", "<Cmd>ToReplBuffer<CR>")
vim.keymap.set("v", "<leader><CR>", "<Cmd>ToReplSelection<CR>")

local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("file_browser")
-- telescope.load_extension("fzf")
vim.keymap.set("n", "<leader>e", "<Cmd>Telescope file_browser<CR>")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fs", builtin.grep_string)
vim.keymap.set("n", "<leader>fj", builtin.jumplist)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
