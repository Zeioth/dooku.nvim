-- This plugin is a documentation generator.
local options = require("dooku.options")
local M = {}

--- Programatically require the backend for the current language.
---@return module language If languages/<filetype>.lua doesn't exist,
--         send a notification and return nil.
function M.require_backend(backend)
  local localPath = debug.getinfo(1, "S").source:sub(2)
  local localPathDir = localPath:match("(.*[/\\])")
  local moduleFilePath = localPathDir .. "backends/" .. backend .. ".lua"
  local success, backend = pcall(dofile, moduleFilePath)

  if success then return backend
  else
    return nil
  end
end

--- Generate the HTML documentation.
function M.generate()
  local filetype = vim.bo.filetype

  if M.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").generate()
  else
    vim.notify(
      "The filetype " .. vim.bo.filetype ..
      " it not supported by Dooku.nvim yet.", vim.log.levels.INFO
    )
  end

  -- -- Should we generate using jsdoc?
  -- if M.exists_in_table(filetype, options.jsdoc_filetypes) then
  --   M.require_backend("jsdoc").generate()
  -- end
  --
  -- -- Should we generate using typedoc?
  -- if M.exists_in_table(filetype, options.typedoc_filetypes) then
  --   M.require_backend("typedoc").generate()
  -- end
  --
  -- -- Should we generate using rustdoc?
  -- if M.exists_in_table(filetype, options.rustdoc_filetypes) then
  --   M.require_backend("rustdoc").generate()
  -- end
  --
  -- -- Should we generate using godoc?
  -- if M.exists_in_table(filetype, options.godoc_filetypes) then
  --   M.require_backend("godoc").generate()
  -- end
end

--- Open the HTML documentation
function M.open()
  local filetype = vim.bo.filetype

  -- Should we open using doxygen?
  if M.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").open()
  else
    vim.notify(
      "The filetype " .. vim.bo.filetype ..
      " it not supported by Dooku.nvim yet.", vim.log.levels.INFO
    )
  end
  -- -- Should we open using jsdoc?
  -- if M.exists_in_table(filetype, options.jsdoc_filetypes) then
  --   M.require_backend("jsdoc").open()
  -- end
  --
  -- -- Should we open using typedoc?
  -- if M.exists_in_table(filetype, options.typedoc_filetypes) then
  --   M.require_backend("typedoc").open()
  -- end
  --
  -- -- Should we open using rustdoc?
  -- if M.exists_in_table(filetype, options.rustdoc_filetypes) then
  --   M.require_backend("rustdoc").open()
  -- end
  --
  -- -- Should we open using godoc?
  -- if M.exists_in_table(filetype, options.godoc_filetypes) then
  --   M.require_backend("godoc").open()
  -- end
end

--- Given a string, convert 'slash' to 'inverted slash' if on windows, and vice versa on UNIX.
-- Then return the resulting string.
---@param path string
---@return string
function M.osPath(path)
  if path == nil then return nil end
  -- Get the platform-specific path separator
  local separator = package.config:sub(1,1)
  return string.gsub(path, '[/\\]', separator)
end

--- Returns bool if the object exists on the table.
function M.exists_in_table(obj, tbl)
    for _, value in ipairs(tbl) do
        if value == obj then
            return true
        end
    end
    return false
end

-- Function to find the project root based on a given list of files/directories
function M.find_project_root(roots)
    local path = vim.fn.expand("%:p:h") -- Get the directory of the current buffer

    while path and path ~= "" do
        for _, root in ipairs(roots) do
            local root_path = path .. "/" .. root

            if vim.fn.isdirectory(root_path) == 1 or vim.fn.filereadable(root_path) == 1 then
                return path
            end
        end

        -- Move up to the parent directory
        path = vim.fn.fnamemodify(path, ":h")
    end

    return nil -- If no root directory is found, return nil
end

--- Deletes a file for UNIX or Windows.
function M.delete_file(file)
    return
end

--- Creates a directory for UNIX or Windows.
function M.create_dir(file)
    return
end

--- Receives two commands, one for UNIX shell and other for windows Powershell.
--  This function runs them depending the current operative system.
function M.run_cmd(sh_cmd, ps_cmd)
    return
end

return M
