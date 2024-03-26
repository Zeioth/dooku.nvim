-- Actions to perform if the backend is godoc.
local M = {}
local utils = require "dooku.utils"
local jobstop = vim.fn.jobstop
local jobstart = utils.jobstart
local config = vim.g.dooku_config

local job

--- It generates the html documentation.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(config.project_root))
  local gomod_file = utils.os_path(cwd .. "/go.mod")
  local gomod_file_exists = vim.loop.fs_stat(gomod_file) and vim.loop.fs_stat(gomod_file).type == 'file' or false

  if gomod_file_exists then
    -- Generate html docs
    if config.on_generate_notification then
      vim.notify("Generating godoc html docs...",
        vim.log.levels.INFO, {title="dooku.nvim"})
    end

    if job then jobstop(job) end -- Running already? kill it
    job = jobstart(config.godoc_cmd, {}, { cwd = cwd })

    -- Open html docs
    if not is_autocmd and config.on_generate_open then M.open() end
  else
    vim.notify("go.mod doesn't exist in your project:\nRun 'go mod init your_module_name' first.",
      vim.log.levels.INFO, {title="dooku.nvim"})
  end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local cwd = utils.os_path(utils.find_project_root(config.project_root))

  if config.on_open_notification then
    vim.notify("Opening godoc html docs...",
      vim.log.levels.INFO, {title="dooku.nvim"})
  end

  jobstart(config.browser_cmd, { config.godoc_html_url }, { cwd = cwd })

end

--- It shows a notification, as this is not necessary for go.
M.auto_setup = function()
  vim.notify(
    ":DookuAutoSetup is not necessary for go.",
    vim.log.levels.INFO, {title="dooku.nvim"}
  )
end

return M
