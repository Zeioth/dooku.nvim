-- Dooku.nivm plugin options.
local M = {}

--- Parse user options, or set the defaults
function M.set(ctx)

  -- General settings ------------------------------------------------------
  M.project_root = ctx.project_root or { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' }
  M.notification_on_generate = ctx.notification_on_generate or true
  M.notification_on_open = ctx.notification_on_open or true
  M.generate_on_write = ctx.generate_on_bufwrite or true
  M.on_generate_open = ctx.on_generate_open or false
  M.auto_setup = ctx.auto_setup or true
  M.browser_cmd = ctx.browser_cmd or "xdg-open"

  -- Doxygen settings ------------------------------------------------------
  M.doxygen_filetypes = ctx.doxygen_filetypes or { 'c', 'cpp', 'cs', 'python', 'd', 'fortran', 'java', 'perl', 'vhdl', 'objc', 'php' }

  -- Doxygen - Open on browser
  M.doxygen_html_file = ctx.doxygen_html_file or "./html/index.html"

  -- Doxygen - auto setup (clone Doxyfile from a repository)
  M.doxygen_clone_config_repo = ctx.doxygen_clone_config_repo or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.doxygen_clone_destiny_dir = ctx.doxygen_clone_destiny_dir or "./doxygen"

end

return M
