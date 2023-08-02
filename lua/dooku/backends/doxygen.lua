-- Actions to perform if the backend is Doxygen.
local M = {}
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local opts = require "dooku.options"

local job

--- Generate the html documentation. If auto_setup is true and the doxygen
--- directoryit don't exist for the project, it will
--- download a doxygen template first.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local doxygen_dir = cwd .. "/" .. opts.doxygen_clone_destiny_dir
  local doxygen_dir_exists = vim.fn.isdirectory(doxygen_dir) == 1

  -- Auto setup
  if opts.auto_setup and doxygen_dir_exists == false then
    M.auto_setup(cwd)
    return
  end

  -- Generate html docs
  if opts.notification_on_open then
    vim.notify("Generating doxygen html docs...", vim.log.levels.INFO)
  end

  if job then uv.process_kill(job, 9) end -- Running already? kill it
  cwd = cwd .. "/" .. opts.doxygen_clone_destiny_dir
  job =
    uv.spawn("doxygen", { args = { "Doxyfile" }, cwd = cwd, detach = true })

  -- Open html docs
  if is_autocmd == false and opts.on_generate_open then M.open() end
end

--- Opens the html documentation
M.open = function()
  if opts.notification_on_open then
    vim.notify("Opening doxygen html docs...", vim.log.levels.INFO)
  end
  local cwd = utils.osPath(
    utils.find_project_root(opts.project_root)
      .. "/"
      .. opts.doxygen_clone_destiny_dir
  )
  uv.spawn(opts.browser_cmd, {
    args = { opts.doxygen_html_file },
    cwd = cwd,
    detach = true,
  })
end

--- Downloads a doxigen template in the project root
function M.auto_setup(cwd)
  vim.notify(
    "Auto setup is enabled. Creating:\n"
      .. utils.os_path(cwd .. "/" .. opts.doxygen_clone_destiny_dir)
      .. "\n\nYou can run the command now.",
    vim.log.levels.INFO
  )
  uv.spawn("git", {
    args = {
      "clone",
      "--single-branch",
      "--depth",
      "1",
      opts.doxygen_clone_config_repo,
      opts.doxygen_clone_destiny_dir,
    },
    cwd = cwd,
    detach = false,
  })
end

return M
