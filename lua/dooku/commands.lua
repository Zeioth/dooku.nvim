-- Commands used in init.lua commands
local options = require "dooku.options"
local utils = require "dooku.utils"
local M = {}


--- Programatically require the backend for the current language.
---@return module language If languages/<filetype>.lua doesn't exist,
--         send a notification and return nil.
function M.require_backend(backend)
  local localPath = debug.getinfo(1, "S").source:sub(2)
  local localPathDir = localPath:match "(.*[/\\])"
  local moduleFilePath = localPathDir .. "backends/" .. backend .. ".lua"
  local success, backend = pcall(dofile, moduleFilePath)

  if success then return backend else return nil end
end

--- Generate the HTML documentation.
function M.generate(is_autocmd)
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, options.typedoc_filetypes) then
    M.require_backend("typedoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, options.jsdoc_filetypes) then
    M.require_backend("jsdoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, options.rustdoc_filetypes) then
    M.require_backend("rustdoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, options.godoc_filetypes) then
    M.require_backend("godoc").generate(is_autocmd)
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " it not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

--- Open the HTML documentation
function M.open()
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").open()
  elseif utils.exists_in_table(filetype, options.typedoc_filetypes) then
    M.require_backend("typedoc").open()
  elseif utils.exists_in_table(filetype, options.jsdoc_filetypes) then
    M.require_backend("jsdoc").open()
  elseif utils.exists_in_table(filetype, options.rustdoc_filetypes) then
    M.require_backend("rustdoc").open()
  elseif utils.exists_in_table(filetype, options.godoc_filetypes) then
    M.require_backend("godoc").open()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " it not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

--- Open the HTML documentation
function M.auto_setup()
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, options.doxygen_filetypes) then
    M.require_backend("doxygen").auto_setup()
  elseif utils.exists_in_table(filetype, options.typedoc_filetypes) then
    M.require_backend("typedoc").auto_setup()
  elseif utils.exists_in_table(filetype, options.jsdoc_filetypes) then
    M.require_backend("jsdoc").auto_setup()
  elseif utils.exists_in_table(filetype, options.rustdoc_filetypes) then
    M.require_backend("rustdoc").auto_setup()
  elseif utils.exists_in_table(filetype, options.godoc_filetypes) then
    M.require_backend("godoc").auto_setup()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " it not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

return M
