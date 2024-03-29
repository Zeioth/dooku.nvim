-- This plugin is a documentation generator.
local M = {}
local uv = vim.uv or vim.loop
local is_windows = uv.os_uname().sysname == "Windows_NT"

---Given a string, convert 'slash' to 'inverted slash' if on windows,
---and vice versa on UNIX. Then return the resulting string.
---@param path string
---@return string|nil,nil
function M.os_path(path)
  if path == nil then return nil end
  -- Get the platform-specific path separator
  local separator = string.sub(package.config, 1, 1)
  return string.gsub(path, "[/\\]", separator)
end

---Wrapper for jobstart.
---On windows, run it with {} so it doesn't spawn a shell.
---On unix, run it as string so it spawn a shell,
---so ENV is available, which is mandatory on termux.
---
---NOTE: In order to work on windows,
---      the executables must be added to path in at windows level.
---@param cmd string command to run.
---@param arguments table arguments to pass to the cmd.
---@param opts table opts to pass.
---@return number job pid of the job, so we can stop it later.
M.jobstart = function(cmd, arguments, opts)
  if arguments == nil then arguments = {} end
  if opts == nil then opts = {} end
  if is_windows then
    return vim.fn.jobstart({ cmd, unpack(arguments) }, opts)
  else
    return vim.fn.jobstart(cmd .. " " .. table.concat(arguments, " "), opts)
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
  local path_separator = string.sub(package.config, 1, 1)
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
