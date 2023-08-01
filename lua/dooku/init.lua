-- This plugin is a documentation generator.
local cmd = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local opts = require("dooku.options")
local utils = require("dooku.utils")

local M = {}

function M.setup(ctx)

  opts.set(ctx)

  cmd("DookuGen", function() utils.generate() end,
    { desc = "Generate the HTML documentation using the adecuated generator for the current filetype" })

  cmd("DookuOpen", function() utils.open() end,
    { desc = "Open the HTML documentation using the specified program, or the default internet browser" })


  autocmd("BufWritePost", {
    desc = "If enabled, generate the HTML docs on write",
    group = augroup("dooku_genearate_on_write", { clear = true }),
    callback = function()
      vim.notify("Generating doxygen html docs...", vim.log.levels.INFO)
      if opts.generate_on_bufwrite then utils.generate(true) end
    end,
  })
end

return M
