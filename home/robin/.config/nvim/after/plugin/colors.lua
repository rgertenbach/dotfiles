local colorscheme = "nightfox"
vim.cmd.colorscheme(colorscheme)

require("nightfox").setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold"
    }
  }
})
