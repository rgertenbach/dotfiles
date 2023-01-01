vim.g.mapleader = " "

-- Toggle netrw to the left
vim.keymap.set("n", "<leader>e", vim.cmd.Vex)

-- Use <leader> k/j to move lines up or down.
vim.keymap.set("n", "<leader>k", ":move .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":move .+1<CR>==")
-- c
-- e
-- b
-- a
