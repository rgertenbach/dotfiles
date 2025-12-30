return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd.colorscheme("nightfox")
      require("nightfox").setup({
        options = {
          styles = {
            keywords = "bold",
            types = "italic,bold"
          }
        }
      })
    end
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- Syntax tree manager for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ignore_install = { "help" },
        sync_install = true,
        auto_install = false,
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "markdown",
          "markdown_inline",
          "bash",
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        modules = {},
      }
      vim.keymap.set("n", "<leader>ast", vim.cmd.InspectTree)
    end,
  },

  {
    "rgertenbach/ToRepl.nvim",
    config = function()
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
    end
  },
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function() require("mini.statusline").setup({}) end
  },
  -- Move selection with <M-[hjkl]>
  {
    "echasnovski/mini.move",
    version = false,
    config = function() require("mini.move").setup({}) end
  },
  -- {
  --   "echasnovski/mini.files",
  --   version = false,
  --   config = function()
  --     local files = require("mini.files")
  --     files.setup({
  --       options = {use_as_default_explorer = false}
  --     })
  --     vim.keymap.set("n", "<leader>-", files.open)
  --   end
  -- },
  {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    config = function()
      require("oil").setup({
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        view_options = {
          show_hidden = true,
        },
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
    end
  }
}
