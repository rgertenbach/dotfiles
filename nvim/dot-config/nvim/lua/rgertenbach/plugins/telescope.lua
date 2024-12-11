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
      vim.keymap.set('n', '<leader>fj', builtin.jumplist)
      vim.keymap.set('n', '<leader>fh', builtin.help_tags)

      telescope.setup({
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      })
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local fb = require("telescope").load_extension("file_browser")
      vim.keymap.set("n", "<leader>e", fb.file_browser)
    end,
  },
}

