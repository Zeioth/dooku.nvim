-- Dooku.nivm plugin options.
local M = {}
local is_windows = package.config:sub(1, 1) == "\\"

--- Parse user options, or set the defaults
function M.set(ctx)

  -- [GENERAL SETTINGS] ----------------------------------------------------
  M.project_root = ctx.project_root or { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' }
  M.notification_on_generate = ctx.notification_on_generate or true
  M.notification_on_open = ctx.notification_on_open or true
  M.generate_on_write = ctx.generate_on_bufwrite or true
  M.on_generate_open = ctx.on_generate_open or false
  M.auto_setup = ctx.auto_setup or true

  -- detect default internet browser
  if is_windows then M.browser_cmd = ctx.browser_cmd or "start"
  else M.browser_cmd = ctx.browser_cmd or "xdg-open" end




  -- [DOXYGEN] --------------------------------------------------------------
  M.doxygen_filetypes = ctx.doxygen_filetypes or {
    'c',
    'cpp',
    'cs',
    'python',
    'd',
    'fortran',
    'java',
    'perl',
    'vhdl',
    'objc',
    'php'
  }

  -- Open on browser
  M.doxygen_html_file = ctx.doxygen_html_file or "./html/index.html"

  -- auto setup (clone Doxyfile from a git repository)
  M.doxygen_clone_config_repo = ctx.doxygen_clone_config_repo or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.doxygen_clone_destiny_dir = ctx.doxygen_clone_destiny_dir or "doxygen"
  M.doxygen_clone_cmd_post = ctx.doxygen_clone_cmd_post or ""



  -- [TYPEDOC] -------------------------------------------------------------
  M.typedoc_filetypes = ctx.typedoc_filetypes or { 'typescript' }

  -- Open on browser
  M.typedoc_html_file = ctx.typedoc_html_file or "./docs/index.html"

  -- auto setup (clone Doxyfile from a git repository)
  M.typedoc_clone_config_repo = ctx.typedoc or "https://github.com/Zeioth/vim-typedoc-template.git"
  M.typedoc_clone_destiny_dir = ctx.typedoc or "./docs"




  -- [JSDOC] ---------------------------------------------------------------
  M.jsdoc_filetypes = ctx.jsdoc_filetypes or { 'javascript' }

  -- Open on browser
  M.jsdoc_html_file = ctx.jsdoc_html_file or "./html/index.html"

  -- auto setup (clone Doxyfile from a git repository)
  M.jsdoc_clone_config_repo = ctx.jsdoc or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.jsdoc_clone_destiny_dir = ctx.jsdoc or "./doxygen"




  -- [RUSTDOC] -------------------------------------------------------------
  M.rustdoc_filetypes = ctx.rustdoc_filetypes or { 'rust' }

  -- Open on browser
  M.rustdoc_html_file = ctx.rustdoc_html_file or "./html/index.html"

  -- auto setup (clone Doxyfile from a git repository)
  M.rustdoc_clone_config_repo = ctx.rustdoc or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.rustdoc_clone_destiny_dir = ctx.rustdoc or "./doxygen"




  -- [GODOC] ---------------------------------------------------------------
  M.godoc_filetypes = ctx.godoc_filetypes or { 'go' }

  -- Open on browser
  M.godoc_html_file = ctx.godoc_html_file or "./html/index.html"

  -- auto setup (clone Doxyfile from a git repository)
  M.godoc_clone_config_repo = ctx.godoc or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.godoc_clone_destiny_dir = ctx.godoc or "./doxygen"
end

return M
