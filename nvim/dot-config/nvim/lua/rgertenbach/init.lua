local m = {}

m.autocomplete = require("rgertenbach.autocomplete")
m.remaps = require("rgertenbach.remaps")
m.opts = require("rgertenbach.opts")

-- Doesn't support all internal features, especially pipes
-- Maybe I can update it
-- sudo apt install tree-sitter-cli
-- To install: clone takegue/tree-sitter-sql-bigquery
-- tree-sitter generate
-- copy the queries/highlights.scm to ~/.local/share/nvim/lazy/nvim-treesitter/queries/sql_bigquery/
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.sql_bigquery = {
--   install_info = {
--     url = "~/src/tree-sitter-sql-bigquery", -- local path or git repo
--     files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     generate_requires_npm = true, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "googlesql" -- if filetype does not match the parser name
-- }
-- vim.treesitter.language.register('sql_bigquery', 'googlesql')
-- vim.treesitter.language.register('sql_bigquery', 'sql')


local function camel_to_snake()
  local word = vim.call('expand','<cword>')
  local out = word:gsub("(%u)", "_%1" ):gsub("(%u)", string.lower):gsub("^_", "")
  vim.cmd("normal! ciw" ..  out)
end

local function snake_to_camel()
  local word = vim.call('expand','<cword>')
  local out = word:gsub("_(.)", string.upper):gsub("^(.)", string.upper)
  vim.cmd("normal! ciw" ..  out)
end

local function toggle_snake_camel()
  local word = vim.call('expand','<cword>')
  if word:match("_") then
    snake_to_camel()
  else
    camel_to_snake()
  end
end

vim.api.nvim_create_user_command("CamelToSnake", camel_to_snake, {})
vim.api.nvim_create_user_command("SnakeToCamel", snake_to_camel, {})
vim.api.nvim_create_user_command("ToggleSnakeCamel", toggle_snake_camel, {})
vim.api.nvim_set_keymap("n", "<C-j>", "", { noremap = true, callback = toggle_snake_camel})

return m
