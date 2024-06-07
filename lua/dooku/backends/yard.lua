-- Actions to perform if the backend is yard.
local M = {}
local utils = require "dooku.utils"
local jobstop = vim.fn.jobstop
local jobstart = utils.jobstart

local job

--- It generates the html documentation. If auto_setup is true and the yard
--- directory doesn't exist on the project, it will
--- download a config template first.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local config = vim.g.dooku_config
  local cwd = utils.os_path(utils.find_project_root(config.project_root))

  -- Generate html docs
  if config.on_generate_notification then
    vim.notify("Generating yard html docs...",
      vim.log.levels.INFO, { title = "dooku.nvim" })
  end

  if job then jobstop(job) end -- Running already? kill it
  job = jobstart(config.yard_cmd, {}, { cwd = cwd })

  -- Open html docs
  if not is_autocmd and config.on_generate_open then M.open() end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local config = vim.g.dooku_config
  local cwd = utils.os_path(
    utils.find_project_root(config.project_root)
    .. "/"
    .. config.yard_docs_dir
  )
  local html_file = utils.os_path(cwd .. "/" .. config.yard_html_file)
  local html_file_exists = vim.loop.fs_stat(html_file) and vim.loop.fs_stat(html_file).type == 'file' or false

  if config.on_open_notification and html_file_exists then
    vim.notify("Opening yard html docs...",
      vim.log.levels.INFO, { title = "dooku.nvim" })
  elseif config.on_open_notification then
    vim.notify("HTML file not found:\nTry running :DookuGenerate",
      vim.log.levels.INFO, { title = "dooku.nvim" })
  end

  if html_file_exists then
    jobstart(config.browser_cmd, { '"' .. html_file .. '"' }, { cwd = cwd })
  end
end

--- It downloads a config template in the project root.
M.auto_setup = function()
  vim.notify(
    ":DookuAutoSetup is not necessary for ruby.",
    vim.log.levels.INFO, { title = "dooku.nvim" }
  )
end

return M
