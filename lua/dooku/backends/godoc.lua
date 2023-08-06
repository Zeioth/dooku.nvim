-- Actions to perform if the backend is godoc.
local M = {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local opts = require "dooku.options"

local job

--- It generates the html documentation.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local gomod_file = utils.os_path(cwd .. "/go.mod")
  local gomod_file_exists = vim.loop.fs_stat(gomod_file) and vim.loop.fs_stat(gomod_file).type == 'file' or false

  if gomod_file_exists then
    -- Generate html docs
    if opts.on_generate_notification then
      vim.notify("Generating godoc html docs...", vim.log.levels.INFO)
    end

    job = vim.fn.jobstart('godoc ' .. opts.godoc_args, { cwd = cwd })
    autocmd("VimLeavePre", {
      desc = "Stop godoc when exiting vim",
      group = augroup("dooku_stop_godoc", { clear = true }),
      callback = function()  vim.fn.jobstop(job) end,
    })

    -- Open html docs
    if not is_autocmd and opts.on_generate_open then M.open() end
  else
    vim.notify("go.mod doesn't exist in your project:\nRun 'go mod init your_module_name' first.", vim.log.levels.INFO)
  end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))

  if opts.on_open_notification then
    vim.notify("Opening godoc html docs...", vim.log.levels.INFO)
  end

  uv.spawn(opts.browser_cmd, {
    args = { opts.godoc_html_url },
    cwd = cwd,
    detach = true,
  })
end

--- It shows a notification, as this is not necessary for go.
M.auto_setup = function()
  vim.notify(
    ":DookuAutoSetup is not necessary for go.",
    vim.log.levels.INFO
  )
end

return M
