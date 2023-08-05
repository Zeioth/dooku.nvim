-- Actions to perform if the backend is rustdoc.
local M = {}
local uv = vim.uv or vim.loop
local utils = require "dooku.utils"
local opts = require "dooku.options"

local job

--- It generates the html documentation.
--- @param is_autocmd boolean if explicitely setted to true, this function will
---                            ignore the option on_generate_open.
function M.generate(is_autocmd)
  local cwd = utils.os_path(utils.find_project_root(opts.project_root))
  local cargo_file = utils.os_path(cwd .. "/Cargo.toml")
  local cargo_file_exists = vim.loop.fs_stat(cargo_file) and vim.loop.fs_stat(cargo_file).type == 'file' or false

  if cargo_file_exists then
    -- Generate html docs
    if opts.on_generate_notification then
      vim.notify("Generating rustdoc html docs...", vim.log.levels.INFO)
    end

    if job then uv.process_kill(job, 9) end -- Running already? kill it
    job = uv.spawn(
      "cargo",
      { args = { "rustdoc", opts.cargo_rustdoc_args, "--", opts.rustdoc_args }, cwd = cwd, detach = true }
    )

    -- Open html docs
    if not is_autocmd and opts.on_generate_open then M.open() end
  else
    vim.notify("Cargo.toml doesn't exist in your project:\nRun 'cargo init' first.", vim.log.levels.INFO)
  end
end

--- It opens the html documentation in the specified internet browser.
M.open = function()
  local crate_name = vim.fn.fnamemodify(utils.find_project_root(opts.project_root), ":t")
  local cwd = utils.os_path(
    utils.find_project_root(opts.project_root)
    .. "/"
    .. opts.rustdoc_docs_dir
  )
  local html_file = cwd .. "/" .. crate_name .. "/" .. opts.rustdoc_html_file
  local html_file_exists = vim.loop.fs_stat(html_file) and vim.loop.fs_stat(html_file).type == 'file' or false

  if opts.on_open_notification and html_file_exists then
    vim.notify("Opening rustdoc html docs...", vim.log.levels.INFO)
  elseif opts.on_open_notification then
    vim.notify("HTML file not found:\nTry running :DookuGenerate", vim.log.levels.INFO)
  end

  uv.spawn(opts.browser_cmd, {
    args = { html_file },
    cwd = cwd,
    detach = true,
  })
end

--- It shows a notification, as this is not necessary for rust.
M.auto_setup = function()
  vim.notify(
    ":DookuAutoSetup is not necessary for rust.",
    vim.log.levels.INFO
  )
end

return M
