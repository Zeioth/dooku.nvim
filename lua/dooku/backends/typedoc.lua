-- Actions to perform if the backend is Doxygen.
local M = {}
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local config = vim.g.dooku_config

local job

--- It generates the html documentation. If auto_setup is true and the typedoc
--- directory doesn't exist on the project, it will
--- download a config template first.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(config.project_root))
  local typedoc_file = utils.os_path(cwd .. "/typedoc.json")
  local typedoc_file_exists = vim.loop.fs_stat(typedoc_file) and vim.loop.fs_stat(typedoc_file).type == 'file' or false

  -- Auto setup typedoc
  if config.auto_setup and not typedoc_file_exists then
    M.auto_setup()
    return
  end

  -- Generate html docs
  if config.on_generate_notification then
    vim.notify("Generating typedoc html docs...", vim.log.levels.INFO)
  end

  if job then uv.process_kill(job, 9) end -- Running already? kill it
  job = uv.spawn(
    "typedoc", { cwd = cwd, detach = true }
  )

  -- Open html docs
  if not is_autocmd and config.on_generate_open then M.open() end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local cwd = utils.os_path(
    utils.find_project_root(config.project_root)
    .. "/"
    .. config.typedoc_docs_dir
  )
  local html_file = cwd .. "/" .. config.typedoc_html_file
  local html_file_exists = vim.loop.fs_stat(html_file) and vim.loop.fs_stat(html_file).type == 'file' or false

  if config.on_open_notification and html_file_exists then
    vim.notify("Opening typedoc html docs...", vim.log.levels.INFO)
  elseif config.on_open_notification then
    vim.notify("HTML file not found:\nTry running :DookuGenerate", vim.log.levels.INFO)
  end

  uv.spawn(config.browser_cmd, {
    args = { config.typedoc_html_file },
    cwd = cwd,
    detach = true,
  })
end

--- It downloads a config template in the project root.
M.auto_setup = function()
  local cwd = utils.os_path(utils.find_project_root(config.project_root))
  local typedoc_file = utils.os_path(cwd .. "/typedoc.json")
  local typedoc_file_exists = vim.loop.fs_stat(typedoc_file) and vim.loop.fs_stat(typedoc_file).type == 'file' or false

  if typedoc_file_exists then
    vim.notify(
      "The fie 'typedoc.json' already exists in the project root dir:\nNothing to be done.",
      vim.log.levels.INFO
    )
    return
  end

  vim.notify(
    "Auto setup is enabled. Creating:\n"
    .. utils.os_path(cwd .. "/" .. config.typedoc_docs_dir)
    .. "\n\nYou can run the command now.",
    vim.log.levels.INFO
  )
  vim.fn.jobstart(
    "git clone --single-branch --depth 1 "
    .. config.typedoc_clone_config_repo
    .. " "
    .. config.typedoc_clone_to_dir
    .. " "
    .. config.typedoc_clone_cmd_post,
    { cwd = cwd, detach = true }
  )
end

return M
