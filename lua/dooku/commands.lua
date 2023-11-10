-- Commands used in init.lua
local config = require "dooku.config"
local utils = require "dooku.utils"
local M = {}


--- Programatically require the backend for the current language.
---@param backend string Name of the backend file.
---@return table|nil language If languages/<filetype>.lua doesn't exist,
--         send a notification and return nil.
function M.require_backend(backend)
  local localPath = debug.getinfo(1, "S").source:sub(2)
  local localPathDir = localPath:match "(.*[/\\])"
  local moduleFilePath = localPathDir .. "backends/" .. backend .. ".lua"
  local success, language = pcall(dofile, moduleFilePath)

  if success then return language else return nil end
end

--- Generate the HTML documentation.
function M.generate(is_autocmd)
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, config.doxygen_filetypes) then
    M.require_backend("doxygen").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, config.typedoc_filetypes) then
    M.require_backend("typedoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, config.jsdoc_filetypes) then
    M.require_backend("jsdoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, config.rustdoc_filetypes) then
    M.require_backend("rustdoc").generate(is_autocmd)
  elseif utils.exists_in_table(filetype, config.godoc_filetypes) then
    if is_autocmd then return else M.require_backend("godoc").generate(is_autocmd) end
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " is not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

--- Open the HTML documentation
function M.open()
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, config.doxygen_filetypes) then
    M.require_backend("doxygen").open()
  elseif utils.exists_in_table(filetype, config.typedoc_filetypes) then
    M.require_backend("typedoc").open()
  elseif utils.exists_in_table(filetype, config.jsdoc_filetypes) then
    M.require_backend("jsdoc").open()
  elseif utils.exists_in_table(filetype, config.rustdoc_filetypes) then
    M.require_backend("rustdoc").open()
  elseif utils.exists_in_table(filetype, config.godoc_filetypes) then
    M.require_backend("godoc").open()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " is not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

--- Open the HTML documentation
function M.auto_setup()
  local filetype = vim.bo.filetype

  if utils.exists_in_table(filetype, config.doxygen_filetypes) then
    M.require_backend("doxygen").auto_setup()
  elseif utils.exists_in_table(filetype, config.typedoc_filetypes) then
    M.require_backend("typedoc").auto_setup()
  elseif utils.exists_in_table(filetype, config.jsdoc_filetypes) then
    M.require_backend("jsdoc").auto_setup()
  elseif utils.exists_in_table(filetype, config.rustdoc_filetypes) then
    M.require_backend("rustdoc").auto_setup()
  elseif utils.exists_in_table(filetype, config.godoc_filetypes) then
    M.require_backend("godoc").auto_setup()
  else
    vim.notify(
      "The filetype "
        .. vim.bo.filetype
        .. " is not supported by Dooku.nvim yet.",
      vim.log.levels.WARN
    )
  end
end

return M
