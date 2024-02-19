-- Generic util functions.

local m = {}

--- Runs a shell command and captures stdout
---
---@param c string The command to run.
---@return string | nil 1 captured stdout or nil if the command failed.
function m.cmd(c)
  local handle = io.popen(c)
  if handle == nil then
    print("Command '" .. c .. "' failed")
    return
  end
  local result = handle:read("*a")
  handle:close()
  return result:gsub("\n$", "")
end

return m


