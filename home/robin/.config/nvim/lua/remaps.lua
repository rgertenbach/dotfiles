--[[ Modding existing behavior ]]--

-- Center when moving half pages.
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Sometimes <C-Space is misinterpreted as <C-@>.
vim.keymap.set("i", "<C-@>", "<C-Space>")
--
-- Stay in place when J'ing.
vim.keymap.set("n", "J", "mzJ`z")


--[[ New maps ]]--
vim.g.mapleader = " "

-- Toggle netrw to the left
vim.keymap.set("n", "<leader>e", vim.cmd.Lex)

-- Use <C-k/j> to move lines up or down.
vim.keymap.set("n", "<leader>-j", ":move '>-2<CR>gv=gv")
vim.keymap.set("n", "<leader>k", ":move '>+1<CR>gv=gv")

-- Don't overwrite paste buffer with text that was pasted over.
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank into system clipboard.
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")
