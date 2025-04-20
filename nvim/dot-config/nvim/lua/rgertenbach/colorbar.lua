-- Mini plugin to highlight lines where a character limit is exceeded.


local m = {}

---@class Config A configuration of line limits.
---@field default integer Default character limit after which to highlight.
---@field mapping table<string, integer> | nil A mapping from filetype to limit.
---@field exclude_ft string[] | nil filetypes to ignore
---@field exclude_bt string[] | nil buftypes to ignore
_ColorbarConfigurationValues = _ColorbarConfigurationValues or {
  default = 80,
  mapping = {},
  exclude_ft = { "", "help" },
  exclude_bt = { "terminal" }
}

m.config = _ColorbarConfigurationValues

--- Adds a colorbar to the current buffer based on filetype.
---
---@return nil
function m.colorbar()
  if vim.list_contains(m.config.exclude_ft, vim.bo.filetype) then return end
  if vim.list_contains(m.config.exclude_bt, vim.bo.buftype) then return end
  local cols = m.config.mapping[vim.bo.filetype] or m.config.default
  if cols == nil then return end
  local warning_cols = cols + 1
  local cmd = "\\%" .. warning_cols .. "v."
  m.clear_colorbar()
  vim.cmd("highlight LineLimit gui=standout")
  vim.fn.matchadd("LineLimit", cmd, -1)
end

function m.clear_colorbar()
  local matches = vim.fn.getmatches()
  for _, match in ipairs(matches) do
    if match.group == "LineLimit" then
      vim.fn.matchdelete(match.id)
    end
  end
end

--- Sets up colorbars across Neovim.
---
---@param config Config
---@return nil
function m.setup(config)
  m.config.default = config.default
  m.config.mapping = config.mapping or {}
  vim.api.nvim_create_augroup("ColorbarAugroup", {})
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufNew", "FileType" },
    { callback = m.colorbar, group = "ColorbarAugroup" }
  )
  vim.api.nvim_create_autocmd(
    { "BufLeave", "WinLeave" },
    { callback = m.clear_colorbar, group = "ColorbarAugroup" }
  )
end

return m
