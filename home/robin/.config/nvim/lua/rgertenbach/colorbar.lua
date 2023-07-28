local m = {}

function m.colorbar(mapping, default)
  local cols = mapping[vim.bo.filetype] or default
  if cols == nil then return end
  local warning_cols = cols + 1
  local cmd = '\\%' .. warning_cols .. 'v'
  vim.fn.matchadd('ColorColumn', cmd, -1)
end

function m.make_colorbar(mapping, default)
  return function() m.colorbar(mapping, default) end
end

function m.setup(config)
  vim.api.nvim_create_autocmd(
    {"BufEnter"},
    {
      callback = m.make_colorbar(config.mapping or {}, config.default)
    }
  )
end

return m
