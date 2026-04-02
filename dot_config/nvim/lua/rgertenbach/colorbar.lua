-- Mini plugin to highlight lines where a character limit is exceeded.

local m = {}

---@class ColorbarConfiguration A configuration of line limits.
---@field default integer Default character limit after which to highlight.
---@field mapping table<string, integer> A mapping from filetype to limit.
---@field exclude_ft table<string, integer> filetypes to ignore
---@field exclude_bt table<string, integer> buftypes to ignore
_ColorbarConfiguration = _ColorbarConfiguration or {
  default = 80,
  mapping = {},
  exclude_ft = { [""] = 1, help = 1 },
  exclude_bt = { terminal = 1 }
}

m.config = _ColorbarConfiguration

--- Adds a colorbar to the current buffer based on filetype.
---
---@return nil
function m.colorbar()
  if m.config.exclude_ft[vim.bo.filetype] then return end
  if m.config.exclude_bt[vim.bo.buftype] then return end
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

---@param limit integer The character limit.
function m.set_default(limit)
  _ColorbarConfiguration.default = limit
end

---@param ft string The filetype.
---@param limit integer The character limit.
function m.set_limit(ft, limit)
  if _ColorbarConfiguration.exclude_ft[ft] then
    _ColorbarConfiguration.exclude_ft[ft] = nil
  end
  _ColorbarConfiguration.mapping[ft] = limit
end

---@param ft string The filetype.
function m.exclude_ft(ft)
  if _ColorbarConfiguration.mapping[ft] then
    _ColorbarConfiguration.mapping[ft] = nil
  end
  _ColorbarConfiguration.exclude_ft[ft] = 1
end

---@param bt string The buftype.
function m.exclude_bt(bt)
  _ColorbarConfiguration.exclude_bt[bt] = 1
end

---@class ColorPartSetupParams
---@field default integer? Default character limit to highlight. (Default: 80)
---@field mapping table<string, integer>? A mapping from filetype to limit.
---@field exclude_ft string[]? filetypes to ignore
---@field exclude_bt string[]? buftypes to ignore

--- Sets up colorbars across Neovim.
---
---@param settings ColorPartSetupParams
---@return nil
function m.setup(settings)
  if settings.default then m.set_default(settings.default) end
  for ft, limit in pairs(settings.mapping or {}) do m.set_limit(ft, limit) end
  for _, ft in ipairs(settings.exclude_ft or {}) do m.exclude_ft(ft) end
  for _, bt in ipairs(settings.exclude_bt or {}) do m.exclude_bt(bt) end

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
