-- Mini plugin to highlight lines where a character limit is exceeded.


local m = {}

-- Keep config between reloads

---@class Config A configuration of line limits.
---@field default integer Default character limit after which to highlight.
---@field mapping table<string, integer> | nil A mapping from filetype to limit.

_ColorbarConfigurationValues = _ColorbarConfigurationValues or {
  default = 80,
  mapping = {}
}

m.config = _ColorbarConfigurationValues

--- Adds a colorbar to the current buffer based on filetype.
---
---@return nil
function m.colorbar()
  local cols = m.config.mapping[vim.bo.filetype] or m.config.default
  if cols == nil then return end
  local warning_cols = cols + 1
  local cmd = "\\%" .. warning_cols .. "v"
  vim.fn.matchadd("ColorColumn", cmd, -1)
end

--- Sets up colorbars across neovim.
---
---@param config Config
---@return nil
function m.setup(config)
  m.config.default = config.default
  m.config.mapping = config.mapping or {}
  vim.api.nvim_create_augroup("ColorbarAugroup", {})
  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufNew" },
    { callback = m.colorbar, group = "ColorbarAugroup" }
  )
end

return m
