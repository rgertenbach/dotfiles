vim.g.mapleader = " "

-- Toggle netrw to the left
vim.keymap.set("n", "<leader>e", vim.cmd.Lex)

-- Sometimes <C-Space is misinterpreted as <C-@>.
vim.keymap.set("i", "<C-@>", "<C-Space>")

-- Use <C-k/j> to move lines up or down.
vim.keymap.set("n", "<C-k>", ":move '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-j>", ":move '>-2<CR>gv=gv")

-- Stay in place when J'ing.
vim.keymap.set("n", "J", "mzJ`z")

-- Don't overwrite paste buffer with text that was pasted over.
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank into system clipboard.
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")
