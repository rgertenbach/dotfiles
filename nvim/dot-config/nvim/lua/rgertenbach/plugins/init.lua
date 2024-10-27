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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- :TSPlaygroundToggle to browse the AST
      "nvim-treesitter/playground",
    },
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
          "r",
          "bash",
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        modules = {},
      }
      vim.keymap.set("n", "<leader>ast", vim.cmd.TSPlaygroundToggle)
    end,
  },

  {
    "rgertenbach/ToRepl.nvim",
    config = function()
      local torepl = require("torepl")
      torepl.setup({
        commands = {
          python = {
            cmd = "~/py/venv/bin/ipython -c \"%s\" -i",
            delimiter = "# PRE",
          },
          csv = {
            cmd = "~/py/venv/bin/python ~/py/csv_loader.py \"%s\"",
            pass_as = torepl.PassMethod.file,
          },
          lua = {
            cmd = "lua -i \"%s\"",
            pass_as = torepl.PassMethod.file,
            after = "os.remove(arg[0])",
            delimiter = "-- PRE",
          },
        }
      })
      vim.keymap.set("n", "<C-Enter>", "<Cmd>ToReplBuffer<CR>")
      vim.keymap.set("v", "<C-Enter>", "<Cmd>ToReplSelection<CR>")
    end
  },
}
