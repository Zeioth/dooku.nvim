-- Actions to perform if the backend is doxygen.
local M = {}
local utils = require("dooku.utils")
local opts = require("dooku.options")

local cwd
local cmd
local job

function M.generate(is_autocmd)

  if opts.notification_on_open then vim.notify("Generating doxygen html docs...", vim.log.levels.INFO) end
  cwd = utils.os_path(utils.find_project_root(opts.project_root))

  -- Auto setup doxygen
  if opts.auto_setup then
    cmd =  "git clone " ..
           opts.doxygen_clone_config_repo .. " " ..
           opts.doxygen_clone_destiny_dir
    vim.system(utils.string_to_array(cmd), { cwd = cwd, detach = true })

    -- post command
    if opts.doxygen_clone_cmd_post ~= "" then
      cmd = opts.doxygen_clone_cmd_post
      vim.system(utils.string_to_array(cmd), { cwd = cwd, detach = true })
    end
  end

  -- Generate html docs
  if job then job.kill(9) end -- Running already? kill it
  cwd = utils.os_path(cwd .. "/" .. opts.doxygen_clone_destiny_dir)
  cmd = "doxygen Doxyfile"
  job = vim.system(utils.string_to_array(cmd), { cwd = cwd, detach = true })

  -- Open html docs
  if is_autocmd == false and opts.on_generate_open then M.open() end
end

M.open = function()
  if opts.notification_on_open then vim.notify("Opening doxygen html docs...", vim.log.levels.INFO) end
  cwd = utils.os_path(utils.find_project_root(opts.project_root) .. "/" .. opts.doxygen_clone_destiny_dir)
  cmd = opts.browser_cmd .. " " .. opts.doxygen_html_file
  vim.system(utils.string_to_array(cmd), { cwd = cwd, detach = true })
end

return M
