local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

---@alias GsubReplacement string|number|function|table
---@alias Substitutions table<string, GsubReplacement>

---@class Bookmarks A list of bookmarks with extra options.
---@field substitutions table<string, GsubReplacement>? Gsub substitutions


---@package
---@param filepath string The filepath to expand.
---@param substitutions Substitutions? A string.gsub compatible substitution.
local function apply_substitutions(filepath, substitutions)
  for pattern, substitution in pairs(substitutions or {}) do
    filepath = filepath:gsub(pattern, substitution)
  end
  return filepath
end

local m = {}

---@param bookmarks Bookmarks
---@param opts any Telescope opts.
---@param prompt_title string? The title for the prompt.
function m.make_bookmarks_picker(bookmarks, opts, prompt_title)
  opts = opts or {}

  for i, mark in ipairs(bookmarks) do
    bookmarks[i] = apply_substitutions(mark, bookmarks.substitutions)
  end

  return pickers.new(opts, {
    prompt_title = prompt_title or "Find Bookmark",
    finder = finders.new_table({
      results = bookmarks,
      entry_maker = make_entry.gen_from_file(opts),
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.generic_sorter(opts),
  })
end

return m
