require("rgertenbach.autocomplete")
local rg_lsp = require("rgertenbach.lsp")
vim.opt.timeout = false       -- Key combos don't expire, y <1 min> y yanks a line.
vim.opt.number = true         -- Show line numbers.
vim.opt.relativenumber = true -- Show relative line numbers.
vim.opt.termguicolors = true  -- 24-bit colors.
vim.opt.signcolumn = "yes"    -- Reserve space for diagnostic icons.
vim.opt.showmatch = true      -- Highlight matching brace.
vim.opt.splitright = true     -- Open vertical splits to the right.
vim.opt.splitbelow = true     -- Open horizontal splits below.
vim.opt.scrolloff = 8         -- Look at least 8 lines ahead.
vim.opt.cursorline = true     -- Highlight current line.
vim.opt.winborder = "rounded" -- Hover windows have borders.

-- Indentation
vim.opt.expandtab = true   -- Spaces instead of tabs, insert tab with <C-v><Tab>.
vim.opt.smartindent = true -- Enable smart auto-indent.
vim.opt.shiftwidth = 4     -- # of auto indent spaces for autoindent (>> etc.)
vim.opt.softtabstop = 4    -- Tab inserts spaces to align to a multiple of 4.


-- Python
vim.g.python3_host_prog = '~/py/venv/bin/python3'

-- Persistent undo history but in /tmp/. This keeps data beteen relaunches.
local undodir = "/tmp/vimundo/"
vim.fn.mkdir(undodir, "-p")
vim.opt.undodir = undodir
vim.opt.undofile = true

local colorbar = require('rgertenbach.colorbar')
colorbar.setup({ default = 80 })
table.insert(colorbar.config.exclude_ft, "trouble")

local function camel_to_snake()
  local word = vim.call('expand', '<cword>')
  local out = word:gsub("(%u)", "_%1"):gsub("(%u)", string.lower):gsub("^_", "")
  vim.cmd("normal! ciw" .. out)
end

local function snake_to_camel()
  local word = vim.call('expand', '<cword>')
  local out = word:gsub("_(.)", string.upper):gsub("^(.)", string.upper)
  vim.cmd("normal! ciw" .. out)
end

local function toggle_snake_camel()
  local word = vim.call('expand', '<cword>')
  if word:match("_") then
    snake_to_camel()
  else
    camel_to_snake()
  end
end

vim.api.nvim_create_autocmd(
  "TermOpen",
  {
    callback = function()
      vim.o.number = false
      vim.o.relativenumber = false
    end
  }
)

vim.api.nvim_create_user_command("CamelToSnake", camel_to_snake, {})
vim.api.nvim_create_user_command("SnakeToCamel", snake_to_camel, {})
vim.api.nvim_create_user_command("ToggleSnakeCamel", toggle_snake_camel, {})
vim.keymap.set("n", "<C-j>", toggle_snake_camel)
vim.keymap.set("i", "<C-@>", "<C-Space>")         -- Prevent <C-Space> being <C-@>.

vim.keymap.set("x", "<leader>p", "\"_dp")         -- Pastem keeping egister intact.
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y") -- Yank to system clipboard.
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")     -- Remove search highlights

-- Make buffer's directory pwd.
vim.keymap.set("n", "<leader>pfd", ":cd %:h<CR>:pwd<CR>")

-- Center after moving half pages.
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Autoformat with LSP where available, otherwise use formatter.nvim
vim.api.nvim_create_augroup("Formatter", {})
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufNew" },
  {
    group = "Formatter",
    callback = function()
      local cmd = "<cmd>Format<CR>" ---@type function|string
      if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" }) > 0 then
        cmd = vim.lsp.buf.format
      end

      vim.keymap.set("n", "<leader>==", cmd, { buffer = 0 })
    end
  }
)

vim.lsp.config("*", { on_attach = rg_lsp.on_attach })
vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
  on_attach = function(client, bufnr)
    rg_lsp.on_attach(client, bufnr)
    -- Cabal files don't support documentHighlight right now.
    if vim.bo.filetype == "cabal" then
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "LspDocumentHighlight" })
    end
  end
})
vim.lsp.enable({ "lua_ls", "bashls", "clangd", "pyright", "hls" })
