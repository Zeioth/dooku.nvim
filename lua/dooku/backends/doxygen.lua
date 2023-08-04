-- Actions to perform if the backend is Doxygen.
local M = {}
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local opts = require "dooku.options"

local job

--- It generates the html documentation. If auto_setup is true and the doxygen
--- directory doesn't exist on the project, it will
--- download a config template first.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local doxygen_dir = utils.os_path(cwd .. "/" .. opts.doxygen_docs_dir)
  local doxyfile = utils.os_path(doxygen_dir .. "/Doxyfile")
  local doxyfile_exists = vim.loop.fs_stat(doxyfile) and vim.loop.fs_stat(doxyfile).type == 'file' or false

  -- Auto setup doxygen
  if opts.auto_setup and doxyfile_exists == false then
    M.auto_setup()
    return
  end

  -- Generate html docs
  if opts.notification_on_generate then
    vim.notify("Generating doxygen html docs...", vim.log.levels.INFO)
  end

  if job then uv.process_kill(job, 9) end -- Running already? kill it
  job = uv.spawn(
    "doxygen",
    { args = { "Doxyfile" }, cwd = doxygen_dir, detach = true }
  )

  -- Open html docs
  if is_autocmd == false and opts.on_generate_open then M.open() end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local cwd = utils.os_path(
    utils.find_project_root(opts.project_root)
    .. "/"
    .. opts.doxygen_docs_dir
  )
  local html_file = cwd .. "/" .. opts.doxygen_html_file
  local html_exists = vim.loop.fs_stat(html_file) and vim.loop.fs_stat(html_file).type == 'file' or false

  if opts.notification_on_open and html_exists then
    vim.notify("Opening doxygen html docs...", vim.log.levels.INFO)
  elseif opts.notification_on_open then
    vim.notify("HTML file not found:\nTry running :DookuGenerate", vim.log.levels.INFO)
  end

  uv.spawn(opts.browser_cmd, {
    args = { opts.doxygen_html_file },
    cwd = cwd,
    detach = true,
  })
end

--- It downloads a config template in the project root.
M.auto_setup = function()
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local doxygen_dir = utils.os_path(cwd .. "/" .. opts.doxygen_docs_dir)
  local doxyfile = utils.os_path(doxygen_dir .. "/Doxyfile")
  local doxyfile_exists = vim.loop.fs_stat(doxyfile) and vim.loop.fs_stat(doxyfile).type == 'file' or false

  if doxyfile_exists then
    vim.notify(
      "The 'doxygen' dir already exists in the project root dir:\nNothing to be done.",
      vim.log.levels.INFO
    )
    return
  end

  vim.notify(
    "Auto setup is enabled. Creating:\n"
    .. utils.os_path(cwd .. "/" .. opts.doxygen_clone_to_dir)
    .. "\n\nYou can run the command now.",
    vim.log.levels.INFO
  )
  vim.fn.jobstart(
    "git clone --single-branch --depth 1 "
    .. opts.doxygen_clone_config_repo
    .. " "
    .. opts.doxygen_clone_to_dir
    .. " "
    .. opts.doxygen_clone_cmd_post,
    { cwd = cwd, detach = true }
  )
end

return M
