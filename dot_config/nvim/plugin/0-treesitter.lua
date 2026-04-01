local function gh(repo)
  return "https://github.com/" .. repo .. ".git"
end

vim.pack.add({
  gh("nvim-treesitter/nvim-treesitter"),
})

require 'nvim-treesitter.config'.setup({
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
})

vim.keymap.set("n", "<leader>ast", vim.cmd.InspectTree)

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      vim.cmd("TSUpdate")
    end
  end
})

