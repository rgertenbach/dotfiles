vim.g.mapleader = " "

-- Toggle netrw to the left
vim.keymap.set("n", "<leader>e", vim.cmd.Lex)

-- Sometimes <C-Space> is misinterpreted as <C-@>.
vim.keymap.set("i", "<C-@>", "<C-Space>")

-- Move selected text around with <C-j> and <C-k>.
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '>-2<CR>gv=gv")
-- Stay in place when J'ing.
vim.keymap.set("n", "J", "mzJ`z")

-- Don't overwrite paste buffer with text that was pasted over.
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Copy into system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")


-- Switch working directory to current file's directory.
vim.keymap.set("n", "<leader>pfd", ":cd %:h<CR>:pwd<CR>")

vim.keymap.set("n", "<leader>pg3", function()
  local abs_path = vim.fn.expand("%:p")
  local found, _, subdir = string.find(abs_path, "^/google/src/(.-)/google3")
  if found then
    vim.cmd.cd("/google/src/" .. subdir .. "/google3")
    vim.cmd.pwd()
    return
  end

  print("Not in a google3 directory:", abs_path)
end)
