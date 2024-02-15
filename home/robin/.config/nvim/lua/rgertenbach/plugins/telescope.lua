return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")


      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)

      -- Google Specific.
      vim.keymap.set('n', '<leader>fpf', ":Telescope codesearch find_files<CR>")
      vim.keymap.set('n', '<leader>fpq', ":Telescope codesearch find_query<CR>")

      telescope.setup({})
    end
  },
}

