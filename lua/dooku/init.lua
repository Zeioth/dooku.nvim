-- This plugin is a documentation generator.
local cmd = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local opts = require("dooku.options")
local commands = require("dooku.commands")

local M = {}

function M.setup(ctx)
  opts.set(ctx)

  cmd("DookuGenerate", function() commands.generate() end,
    { desc = "Generate the HTML documentation using the adecuated generator for the current filetype" })

  cmd("DookuOpen", function() commands.open() end,
    { desc = "Open the HTML documentation using the specified program, or the default internet browser" })

  cmd("DookuAutoSetup", function() commands.auto_setup() end,
    { desc = "If the project doesn't have the documentation enabled, it does it for you." })

  autocmd("BufWritePost", {
    desc = "If enabled, generate the HTML docs on write",
    group = augroup("dooku_genearate_on_write", { clear = true }),
    callback = function() if opts.on_write_generate then commands.generate(true) end end,
  })
end

return M
