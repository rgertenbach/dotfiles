local function config()
  local formatter = require("formatter")
  local formatters = {
    filetype = {
      lua = { require("formatter.filetypes.lua").stylua },
      python = { require("formatter.filetypes.python").black },
      bash = { require("formatter.filetypes.sh").shfmt },
      -- Instead of autocmd
      -- "BufWritePre", { command = ":%s/\\s\\+$//e" }
      ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
    }
  }
  formatter.setup(formatters)
end


local formatter = {
  "mhartington/formatter.nvim",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
  },
  config = config
}

return { formatter }
