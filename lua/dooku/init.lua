-- This plugin is a documentation generator.
local cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd
local utils = require("dooku.utils")

local M = {}

function M.setup(opts)
  require("dooku.config").set(opts)
  local config = vim.g.dooku_config

  cmd("DookuGenerate",
    function()
      for _, backend in ipairs(utils.get_backends()) do
        backend.generate()
      end
    end,
    { desc = "Generate the HTML documentation using the adecuated generator for the current filetype" })

  cmd("DookuOpen",
    function()
      for _, backend in ipairs(utils.get_backends()) do
        backend.open()
      end
    end,
    { desc = "Open the HTML documentation using the specified program, or the default internet browser" })

  cmd("DookuAutoSetup",
    function()
      for _, backend in ipairs(utils.get_backends()) do
        backend.auto_setup()
      end
    end,
    { desc = "If the project doesn't have the documentation enabled, it does it for you." })

  autocmd("BufWritePost", {
    desc = "If enabled, generate the HTML docs on bufwrite",
    callback = function()
      if config.on_bufwrite_generate then
        local is_autocmd = true
        for _, backend in ipairs(utils.get_backends()) do
          backend.generate(is_autocmd)
        end
      end
    end,
  })
end

return M
