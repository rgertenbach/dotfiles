vim.g.mapleader = " "

-- Toggle netrw to the left
vim.keymap.set("n", "<leader>e", ":Telescope file_browser<CR>")

-- Sometimes <C-Space> is misinterpreted as <C-@>.
vim.keymap.set("i", "<C-@>", "<C-Space>")

-- Move selected text around with <C-j> and <C-k>.
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '>-2<CR>gv=gv")

-- Don't overwrite paste buffer with text that was pasted over.
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Copy into system clipboard.
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")


-- Switch working directory to current file's directory.
vim.keymap.set("n", "<leader>pfd", ":cd %:h<CR>:pwd<CR>")
