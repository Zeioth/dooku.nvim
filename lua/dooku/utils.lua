-- This plugin is a documentation generator.
local options = require "dooku.options"
local M = {}

--- Programatically require the backend for the current language.
---@return module language If languages/<filetype>.lua doesn't exist,
--         send a notification and return nil.
function M.require_backend(backend)
  local localPath = debug.getinfo(1, "S").source:sub(2)
  local localPathDir = localPath:match "(.*[/\\])"
  local moduleFilePath = localPathDir .. "backends/" .. backend .. ".lua"
  local success, backend = pcall(dofile, moduleFilePath)

  if success then
    return backend
  else
    return nil
  end
end

--- Generate the HTML documentation.
function M.generate()
  local filetype = vim.bo.filetype

  if M.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").generate()
  elseif M.exists_in_table(filetype, options.typedoc_filetypes) then
    M.require_backend("jsdoc").generate()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " it not supported by Dooku.nvim yet.",
      vim.log.levels.INFO
    )
  end
end

--- Open the HTML documentation
function M.open()
  local filetype = vim.bo.filetype

  if M.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").open()
  elseif M.exists_in_table(filetype, options.typedoc_filetypes) then
    M.require_backend("jsdoc").open()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " it not supported by Dooku.nvim yet.",
      vim.log.levels.INFO
    )
  end
end

--- Given a string, convert 'slash' to 'inverted slash' if on windows, and vice versa on UNIX.
-- Then return the resulting string.
---@param path string
---@return string
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

--- Function to find the project root based on a given list of files/directories.
--  Compatible with UNIX and Windows.
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

  return nil -- If no root directory is found, return nil
end

--- Converts string to string[]
function M.string_to_array(input_string)
    local cmd_array = {}
    for str in input_string:gmatch("%S+") do
        table.insert(cmd_array, str)
    end
    return cmd_array
end

return M
