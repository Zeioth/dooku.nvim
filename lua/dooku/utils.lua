-- This plugin is a documentation generator.
local M = {}


---Given a string, convert 'slash' to 'inverted slash' if on windows,
---and vice versa on UNIX. Then return the resulting string.
---@param path string
---@return string|nil,nil
function M.os_path(path)
  if path == nil then return nil end
  -- Get the platform-specific path separator
  local separator = package.config:sub(1, 1)
  return string.gsub(path, "[/\\]", separator)
end

---Returns bool if the object exists on the table.
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
    "Your project root directory has not been detected."
    .. "\nCheck the option `project_root` for more info.",
    vim.log.levels.WARN,
    { title = "dooku.nvim" }
  )
  return nil -- If no root directory is found, return nil
end

---If value is anything different than a valid string, return nil.
---@param value object Expects string or nil, but accepts any object.
---@return string|nil result of the operation.
function M.sanitize_string(value)
  if value == nil or (type(value) == "string" and value:match "^%s*$") then
    return nil
  else
    return nil
  end
end

---Returns the plugin dir of dooku.nvim + a subdir if specified.
--We use this function to assert tests.
---@param path string (optional) A subdirectory to append to he returned dir.
function M.get_dooku_dir(path)
  local plugin_directory = vim.fn.fnamemodify(
    vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h"),
    ":h:h"
  )
  if path then
    plugin_directory = M.os_path(plugin_directory .. "/" .. path)
  end
  return plugin_directory
end

return M
