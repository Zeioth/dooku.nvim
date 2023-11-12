-- Dooku.nivm plugin options.
local M = {}
local is_windows = package.config:sub(1, 1) == "\\"
local utils = require "dooku.utils"

--- Parse user options, or set the defaults
function M.set(opts)
  -- [GENERAL SETTINGS]
  -- -----------------------------------------------------------------------
  M.project_root = opts.project_root
      or { ".git", ".hg", ".svn", ".bzr", "_darcs", "_FOSSIL_", ".fslckout" }
  M.on_generate_notification = opts.on_generate_notification or true
  M.on_open_notification = opts.on_open_notification or true
  M.on_write_generate = opts.on_write_generate or true
  M.on_generate_open = opts.on_generate_open or true
  M.auto_setup = opts.auto_setup or true

  -- detect default internet browser
  if is_windows then
    M.browser_cmd = opts.browser_cmd or "start"
  else
    M.browser_cmd = opts.browser_cmd or "xdg-open"
  end

  -- [DOXYGEN]
  -- ------------------------------------------------------------------------
  M.doxygen_filetypes = opts.doxygen_filetypes
      or {
        "c",
        "cpp",
        "cs",
        "python",
        "d",
        "fortran",
        "java",
        "perl",
        "vhdl",
        "objc",
        "php",
      }

  -- Open on browser
  -- Defaults: cd doxygen,
  --           open './html/index.html' using the default interner browser.
  M.doxygen_docs_dir = opts.doxygen_htmldocs_dir or "doxygen"
  M.doxygen_html_file = opts.doxygen_html_file
      or utils.os_path "html/index.html"

  -- Auto setup
  -- Defaults: clone the repo into 'doxygen'.
  M.doxygen_clone_config_repo = opts.doxygen_clone_config_repo
      or "https://github.com/Zeioth/vim-doxygen-template.git"
  M.doxygen_clone_to_dir = opts.doxygen_clone_to_dir or "doxygen"
  M.doxygen_clone_cmd_post = opts.doxygen_clone_cmd_post or ""

  -- [TYPEDOC]
  -- -----------------------------------------------------------------------
  M.typedoc_filetypes = opts.typedoc_filetypes or { "typescript" }

  -- Open on browser
  -- Defaults: cd 'docs',
  --           open './index.html' using the default interner browser.
  M.typedoc_docs_dir = opts.typedoc_htmldocs_dir or utils.os_path "docs"
  M.typedoc_html_file = opts.typedoc_html_file or utils.os_path "index.html"

  -- Auto setup
  -- Defaults: clone the repo into 'vim-typedoc-template',
  --           copy 'typedoc.json' into the project root,
  --           delete 'vim-typedoc-template'.
  M.typedoc_clone_config_repo = opts.typedoc_clone_config_repo
      or "https://github.com/Zeioth/vim-typedoc-template.git"
  M.typedoc_clone_to_dir = opts.typedoc_clone_to_dir
      or M.typedoc_clone_config_repo:match ".+/(.-)%.git" -- URL's repo name
  M.typedoc_clone_cmd_post = opts.typedoc_clone_cmd_post
      or
      (is_windows and "&& copy " .. M.typedoc_clone_to_dir .. "\\typedoc.json .\\typedoc.json && rmdir \\s \\q " .. M.typedoc_clone_to_dir)
      or (
        "&& cp "
        .. M.typedoc_clone_to_dir
        .. "/typedoc.json ./typedoc.json && "
        .. " rm -rf "
        .. M.typedoc_clone_to_dir
      )

  -- [JSDOC]
  -- -----------------------------------------------------------------------
  M.jsdoc_filetypes = opts.jsdoc_filetypes or { "javascript" }

  -- Open on browser
  -- Defaults: cd 'docs',
  --           open './index.html' using the default interner browser.
  M.jsdoc_docs_dir = opts.jsdoc_htmldocs_dir or utils.os_path "docs"
  M.jsdoc_html_file = opts.jsdoc_html_file or utils.os_path "index.html"

  -- Auto setup
  -- Defaults: clone the repo into 'vim-jsdoc-template',
  --           copy 'jsdoc.json' into the project root,
  --           delete 'vim-jsdoc-template'.
  M.jsdoc_clone_config_repo = opts.jsdoc_clone_config_repo
      or "https://github.com/Zeioth/vim-jsdoc-template.git"
  M.jsdoc_clone_to_dir = opts.jsdoc_clone_to_dir
      or M.jsdoc_clone_config_repo:match ".+/(.-)%.git" -- URL's repo name
  M.jsdoc_clone_cmd_post = opts.jsdoc_clone_cmd_post
      or
      (is_windows and "&& copy " .. M.jsdoc_clone_to_dir .. "\\jsdoc.json .\\jsdoc.json && rmdir \\s \\q " .. M.jsdoc_clone_to_dir)
      or (
        "&& cp "
        .. M.jsdoc_clone_to_dir
        .. "/jsdoc.json ./jsdoc.json && "
        .. " rm -rf "
        .. M.jsdoc_clone_to_dir
      )

  -- [RUSTDOC]
  -- -----------------------------------------------------------------------
  M.rustdoc_filetypes = opts.rustdoc_filetypes or { "rust" }

  -- Open on browser
  -- Defaults : target/doc/crate_name/index.html
  --            crate_name value will always be 'project root' dir name.
  M.rustdoc_docs_dir = opts.rustdoc_htmldocs_dir or utils.os_path "target/doc"
  M.rustdoc_html_file = opts.rustdoc_html_file or "index.html"

  -- args for rustdoc
  M.cargo_rustdoc_args = opts.cargo_rustdoc_args or ""
  M.rustdoc_args = opts.rustdoc_args or ""

  -- [GODOC]
  ---------------------------------------------------------------
  M.godoc_filetypes = opts.godoc_filetypes or { "go" }

  -- Open on browser
  M.godoc_html_url = opts.godoc_html_file or "localhost:6060"

  -- Args for godoc
  M.godoc_args = opts.godoc_args or ""

  -- After setting the config
  ---------------------------------------------------------------
  M = utils.sanitize_config(M) -- convert "" vales to nil
  vim.g.dooku_config = M       -- expose the config as global
end

return M
