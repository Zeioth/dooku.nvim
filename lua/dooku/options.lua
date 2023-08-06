-- Dooku.nivm plugin options.
local M = {}
local is_windows = package.config:sub(1, 1) == "\\"
local utils = require("dooku.utils")

--- Parse user options, or set the defaults
function M.set(ctx)

  -- [GENERAL SETTINGS] ----------------------------------------------------
  M.project_root = ctx.project_root or { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' }
  M.on_generate_notification = ctx.on_generate_notification or true
  M.on_open_notification = ctx.on_open_notification or true
  M.on_write_generate = ctx.on_write_generate or true
  M.on_generate_open = ctx.on_generate_open or true
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
  -- Defaults: cd doxygen,
  --           open './html/index.html' using the default interner browser.
  M.doxygen_docs_dir = ctx.doxygen_htmldocs_dir or "doxygen"
  M.doxygen_html_file = ctx.doxygen_html_file or utils.os_path("html/index.html")

  -- auto setup
  -- Defaults: clone the repo into 'doxygen'.
  M.doxygen_clone_config_repo = ctx.doxygen_clone_config_repo or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.doxygen_clone_to_dir = ctx.doxygen_clone_to_dir or "doxygen"
  M.doxygen_clone_cmd_post = ctx.doxygen_clone_cmd_post or ""



  -- [TYPEDOC] -------------------------------------------------------------
  M.typedoc_filetypes = ctx.typedoc_filetypes or { 'typescript' }

  -- Open on browser
  -- Defaults: cd 'docs',
  --           open './index.html' using the default interner browser.
  M.typedoc_docs_dir = ctx.typedoc_htmldocs_dir or utils.os_path("docs")
  M.typedoc_html_file = ctx.typedoc_html_file or utils.os_path("index.html")

  -- auto setup
  -- Defaults: clone the repo into 'vim-typedoc-template',
  --           copy 'typedoc.json' into the project root,
  --           delete 'vim-typedoc-template'.
  M.typedoc_clone_config_repo = ctx.typedoc_clone_config_repo or "https://github.com/Zeioth/vim-typedoc-template.git"
  M.typedoc_clone_to_dir = ctx.typedoc_clone_to_dir or M.typedoc_clone_config_repo:match(".+/(.-)%.git") -- URL's repo name
  M.typedoc_clone_cmd_post = ctx.typedoc_clone_cmd_post or (is_windows and "&& copy " .. M.typedoc_clone_to_dir .. "\\typedoc.json .\\typedoc.json && rmdir \\s \\q " .. M.typedoc_clone_to_dir) or ("&& cp " .. M.typedoc_clone_to_dir .. "/typedoc.json ./typedoc.json && " .. " rm -rf " .. M.typedoc_clone_to_dir)


  -- [JSDOC] ---------------------------------------------------------------
  M.jsdoc_filetypes = ctx.jsdoc_filetypes or { 'javascript' }

  -- Open on browser
  -- Defaults: cd 'docs',
  --           open './index.html' using the default interner browser.
  M.jsdoc_docs_dir = ctx.jsdoc_htmldocs_dir or utils.os_path("docs")
  M.jsdoc_html_file = ctx.jsdoc_html_file or utils.os_path("index.html")

  -- auto setup
  -- Defaults: clone the repo into 'vim-jsdoc-template',
  --           copy 'jsdoc.json' into the project root,
  --           delete 'vim-jsdoc-template'.
  M.jsdoc_clone_config_repo = ctx.jsdoc_clone_config_repo or "https://github.com/Zeioth/vim-jsdoc-template.git"
  M.jsdoc_clone_to_dir = ctx.jsdoc_clone_to_dir or M.jsdoc_clone_config_repo:match(".+/(.-)%.git") -- URL's repo name
  M.jsdoc_clone_cmd_post = ctx.jsdoc_clone_cmd_post or (is_windows and "&& copy " .. M.jsdoc_clone_to_dir .. "\\jsdoc.json .\\jsdoc.json && rmdir \\s \\q " .. M.jsdoc_clone_to_dir) or ("&& cp " .. M.jsdoc_clone_to_dir .. "/jsdoc.json ./jsdoc.json && " .. " rm -rf " .. M.jsdoc_clone_to_dir)



  -- [RUSTDOC] -------------------------------------------------------------
  M.rustdoc_filetypes = ctx.rustdoc_filetypes or { 'rust' }

  -- Open on browser
  -- Defaults : target/doc/crate_name/index.html
  --            crate_name value will always be 'project root' dir name.
  M.rustdoc_docs_dir = ctx.rustdoc_htmldocs_dir or utils.os_path("target/doc")
  M.rustdoc_html_file = ctx.rustdoc_html_file or "index.html"

  -- args for rustdoc
  M.cargo_rustdoc_args = ctx.cargo_rustdoc_args or ""
  M.rustdoc_args = ctx.rustdoc_args or ""


  -- [GODOC] ---------------------------------------------------------------
  M.godoc_filetypes = ctx.godoc_filetypes or { 'go' }

  -- Open on browser
  M.godoc_html_url = ctx.godoc_html_file or "localhost:6060"

  -- args for godoc
  M.godoc_args = ctx.godoc_args or ""
end

return M
