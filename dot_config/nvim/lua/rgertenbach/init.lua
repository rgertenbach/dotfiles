---- Default Behavior ----

-- Visual Settings.
vim.opt.timeout = false -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.relativenumber = true -- Show relative line numbers.
vim.opt.number = true -- Show line numbers.
vim.opt.termguicolors = true -- 24-bit colors.
vim.opt.signcolumn = "yes" -- Reserve space for diagnostic icons.
vim.opt.showmatch = true -- Highlight matching brace.
vim.opt.splitright = true -- Open vertical splits to the right.
vim.opt.splitbelow = true -- Open horizontal splits below.
vim.opt.scrolloff = 8 -- Look at least 8 lines ahead.
vim.opt.cursorline = true -- Highlight current line.
vim.opt.winborder = "rounded" -- Hover windows have borders.

-- Indentation
vim.opt.expandtab = true -- Spaces instead of tabs, insert tab with <C-v><Tab>.
vim.opt.smartindent = true -- Enable smart auto-indent.
vim.opt.shiftwidth = 4 -- # of auto indent spaces for autoindent (>> etc.)
vim.opt.softtabstop = 4 -- Tab inserts spaces to align to a multiple of 4.

vim.g.mapleader = " " -- <Leader>
vim.g.maplocalleader = " " -- <LocalLeader>

-- Language specific.
vim.g.python3_host_prog = "~/py/venv/bin/python3"
vim.g.markdown_fenced_languages = { "bash", "python", "c" }
vim.g.c_syntax_for_h = 1

-- Persistent undo history but in /tmp/. This keeps data beteen relaunches.
local undodir = "/tmp/vimundo/"
vim.fn.mkdir(undodir, "-p")
vim.opt.undodir = undodir
vim.opt.undofile = true

require("rgertenbach.colorbar").setup({
	default = 80,
	exclude_ft = {
		"",
		"help",
		"TelescopePrompt",
		"TelescopeResults",
		"TelescopePreview",
	},
	exclude_bt = { "terminal", "prompt" },
})

-- Experimental message / cmdline presentation.
-- g< enters the message output as a buffer.
require("vim._core.ui2").enable({})

---- Keymaps and commands ----

-- Replace text under visual selection in buffer.
vim.keymap.set("v", "<C-s>", '"zy:%s/z//g<left><left>')
vim.keymap.set("i", "<C-@>", "<C-Space>") -- Prevent <C-Space> being <C-@>.
vim.keymap.set("x", "<leader>p", '"_dp') -- Paste keeping register intact.
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- Yank to system clipboard.
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>") -- Remove search highlights

local buf = require("rgertenbach.buf")
vim.api.nvim_create_user_command("CamelToSnake", buf.camel_to_snake, {})
vim.api.nvim_create_user_command("SnakeToCamel", buf.snake_to_camel, {})
vim.api.nvim_create_user_command("ToggleSnakeCamel", buf.toggle_snake_camel, {})
vim.keymap.set("n", "<C-j>", buf.toggle_snake_camel)
vim.api.nvim_create_user_command("Align", buf.align_buffer, { nargs = 1, range = "%", preview = buf.align_buffer })

-- Make buffer's directory pwd.
vim.keymap.set("n", "<leader>pfd", ":cd %:h<CR>:pwd<CR>")

-- Center after moving half pages.
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

---- LSP Setup ----

local dochl = vim.api.nvim_create_augroup("LspDocHighlight", { clear = false })

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			buf = bufnr,
			desc = "[G]o to [D]efinition",
		})

		if client and client:supports_method("textDocument/documentHighlight") then
			vim.api.nvim_create_autocmd(
				{ "CursorHold", "CursorHoldI" },
				{ buffer = bufnr, group = dochl, callback = vim.lsp.buf.document_highlight }
			)
			vim.api.nvim_create_autocmd(
				{ "CursorMoved" },
				{ buffer = bufnr, group = dochl, callback = vim.lsp.buf.clear_references }
			)
		end
	end,
})

vim.lsp.enable({ "lua_ls", "bashls", "clangd", "basedpyright", "ts_ls", "html", "hls" })

vim.keymap.set("n", "<Leader>==", function()
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		if client:supports_method("textDocument/formatting", 0) then
			vim.lsp.buf.format()
			return
		end
		vim.cmd("Format")
	end
end, { desc = "Format Buffer with LSP if possible, otherwise try :Format" })
