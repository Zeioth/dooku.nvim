--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/yard.lua

local M = {}
local ms = 2000 -- wait time
local yard = require("dooku.backends.yard")
local example_dir = require("dooku.utils").get_dooku_dir("tests/examples/ruby/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Yard backend", vim.log.levels.INFO)


-- TEST: yard.auto_setup()
--=============================================================================
function M.test_auto_setup()
  -- ARRANGE
  vim.notify("Testing `yard.auto_setup()`.", vim.log.levels.INFO)

  -- ACT
  yard.auto_setup()
  vim.wait(ms)
end


-- TEST: yard.generate()
--=============================================================================
function M.test_generate()
  -- ARRANGE
  vim.notify("Testing `yard.generate(false)`.", vim.log.levels.INFO)

  -- ACT
  yard.generate(false)
  vim.wait(ms)
end


-- TEST: yard.open()
--=============================================================================
function M.test_open()
  -- ARRANGE
  vim.notify("Testing `yard.open()`.", vim.log.levels.INFO)

  -- ACT
  yard.open()
  vim.wait(ms)

  -- ASSERT (This step is currently visually asserted)
  vim.notify(
    "Please, check on your internet browser that yard opened correctly.",
    vim.log.levels.WARN)
end


-- RUN TESTS
--=======================================================================
M.test_auto_setup()
M.test_generate()
M.test_open()
