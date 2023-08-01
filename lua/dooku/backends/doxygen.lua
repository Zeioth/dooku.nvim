-- Actions to perform if the backend is Doxygen.
local M = {}
local uv = vim.uv or vim.loop
local utils = require("dooku.utils")
local opts = require("dooku.options")

local job

function M.generate(is_autocmd)

  if opts.notification_on_open then vim.notify("Generating doxygen html docs...", vim.log.levels.INFO) end

  -- Auto setup doxygen
  if opts.auto_setup then
    uv.spawn("git", {
      args = {
        "clone",
        opts.doxygen_clone_config_repo,
        opts.doxygen_clone_destiny_dir
      }, detach = true })
  end

  -- Generate html docs
  if job then uv.process_kill(job, 9) end -- Running already? kill it
  local proj_root = utils.find_project_root(opts.project_root) .. "/" .. opts.doxygen_clone_destiny_dir
  job = uv.spawn("doxygen", { args = { "Doxyfile" }, cwd = proj_root,  detach = true })

  -- Open html docs
  if is_autocmd == false and opts.on_generate_open then M.open() end
end

M.open = function()
  if opts.notification_on_open then vim.notify("Opening doxygen html docs...", vim.log.levels.INFO) end
  local proj_root = utils.find_project_root(opts.project_root) .. "/" .. opts.doxygen_clone_destiny_dir
  uv.spawn(opts.browser_cmd, { args = { opts.doxygen_html_file }, cwd = proj_root, detach = true })
end

return M
