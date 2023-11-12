-- This plugin is a documentation generator.
local M = {}


---Given a string, convert 'slash' to 'inverted slash' if on windows, and vice versa on UNIX.
---Then return the resulting string.
---@param path string
---@return string|nil,nil
function M.os_path(path)
  if path == nil then return nil end
  -- Get the platform-specific path separator
  local separator = package.config:sub(1, 1)
  return string.gsub(path, "[/\\]", separator)
end

--- Returns bool if the object exists on the table.
---@param obj object
---@param tbl table
---@return boolean
function M.exists_in_table(obj, tbl)
  for _, value in ipairs(tbl) do
    if value == obj then return true end
  end
  return false
end

---Function to find the project root based on a given list of files/directories.
---Compatible with UNIX and Windows.
---@param roots table A table of strings.
function M.find_project_root(roots)
  local path = vim.fn.expand "%:p:h" -- Get the directory of the current buffer

  -- Normalize the path separator based on the platform
  local path_separator = package.config:sub(1, 1)
  path = path:gsub("[/\\]", path_separator)

  while path and path ~= "" do
    for _, root in ipairs(roots) do
      local root_path = path .. path_separator .. root

      if
        vim.fn.isdirectory(root_path) == 1
        or vim.fn.filereadable(root_path) == 1
      then
        return path
      end
    end

    -- Move up to the parent directory
    path = vim.fn.fnamemodify(path, ":h")
  end

  -- notify the user
  vim.notify(
    "Your project root directory has not been detected." ..
    "\nCheck the option `project_root` for more info.",
    vim.log.levels.WARN, {title = "dooku.nvim"}
  )
  return nil -- If no root directory is found, return nil
end

---Given a table, return it back after converting every "" value to nil.
--
--This allow config values to be used on uv.spawn() args in the backend
--without having to check one by one.
---@param tbl table A table {}
---@return table result The original table without nil or "" values.
function M.sanitize_config(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    if type(value) == "string" and value == "" then
      result[key] = nil
    else
      result[key] = value
    end
  end
  return result
end

return M
