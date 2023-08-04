-- Actions to perform if the backend is Doxygen.
local M = {}
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local opts = require "dooku.options"

local job

--- It generates the html documentation. If auto_setup is true and the jsdoc
--- directory doesn't exist on the project, it will
--- download a config template first.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local jsdoc_file = utils.os_path(cwd .. "/jsdoc.json")
  local jsdoc_file_exists = vim.loop.fs_stat(jsdoc_file) and vim.loop.fs_stat(jsdoc_file).type == 'file' or false

  -- Auto setup jsdoc
  if opts.auto_setup and not jsdoc_file_exists then
    M.auto_setup()
    return
  end

  -- Generate html docs
  if opts.on_generate_notification then
    vim.notify("Generating jsdoc html docs...", vim.log.levels.INFO)
  end

  if job then uv.process_kill(job, 9) end -- Running already? kill it
  job = uv.spawn(
    "jsdoc", { args = { "-c", "jsconfig.json" }, cwd = cwd, detach = true }
  )

  -- Open html docs
  if not is_autocmd and opts.on_generate_open then M.open() end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local cwd = utils.os_path(
    utils.find_project_root(opts.project_root)
    .. "/"
    .. opts.jsdoc_docs_dir
  )
  local html_file = cwd .. "/" .. opts.jsdoc_html_file
  local html_file_exists = vim.loop.fs_stat(html_file) and vim.loop.fs_stat(html_file).type == 'file' or false

  if opts.on_open_notification and html_file_exists then
    vim.notify("Opening jsdoc html docs...", vim.log.levels.INFO)
  elseif opts.on_open_notification then
    vim.notify("HTML file not found:\nTry running :DookuGenerate", vim.log.levels.INFO)
  end

  uv.spawn(opts.browser_cmd, {
    args = { opts.jsdoc_html_file },
    cwd = cwd,
    detach = true,
  })
end

--- It downloads a config template in the project root.
M.auto_setup = function()
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local jsdoc_file = utils.os_path(cwd .. "/jsdoc.json")
  local jsdoc_file_exists = vim.loop.fs_stat(jsdoc_file) and vim.loop.fs_stat(jsdoc_file).type == 'file' or false

  if jsdoc_file_exists then
    vim.notify(
      "The fie 'jsdoc.json' already exists in the project root dir:\nNothing to be done.",
      vim.log.levels.INFO
    )
    return
  end

  vim.notify(
    "Auto setup is enabled. Creating:\n"
    .. utils.os_path(cwd .. "/" .. opts.jsdoc_docs_dir)
    .. "\n\nYou can run the command now.",
    vim.log.levels.INFO
  )
  vim.fn.jobstart(
    "git clone --single-branch --depth 1 "
    .. opts.jsdoc_clone_config_repo
    .. " "
    .. opts.jsdoc_clone_to_dir
    .. " "
    .. opts.jsdoc_clone_cmd_post,
    { cwd = cwd, detach = true }
  )
end

return M
