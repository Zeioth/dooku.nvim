--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/jsdoc.lua

local M = {}
local ms = 2000 -- wait time
local jsdoc = require("dooku.backends.jsdoc")
local example_dir = require("dooku.utils").get_dooku_dir("tests/examples/javascript/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: jsdoc backend", vim.log.levels.INFO)


-- TEST: jsdoc.auto_setup()
--=============================================================================
function M.test_auto_setup()
  -- ARRANGE
  vim.notify("Testing `jsdoc.auto_setup()`.", vim.log.levels.INFO)

  -- ACT
  jsdoc.auto_setup()
  vim.wait(ms)

  -- ASSERT
  local config_generated_ok = vim.fn.filereadable(
    require("dooku.utils").get_dooku_dir("tests/examples/javascript/")
      .. "jsdoc.json"
  ) == 1
  if config_generated_ok == false then
    vim.notify(
      "`<project_root>/jsdoc.json` file not found. Check `auto_setup()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: jsdoc.generate()
--=============================================================================
function M.test_generate()
  -- ARRANGE
  vim.notify("Testing `jsdoc.generate(false)`.", vim.log.levels.INFO)

  -- ACT
  jsdoc.generate(false)
  vim.wait(ms)

  -- ASSERT
  local docs_generated_ok = vim.fn.isdirectory(
    require("dooku.utils").get_dooku_dir("tests/examples/javascript/docs/")
  ) == 1
  print(docs_generated_ok)
  if docs_generated_ok == false then
    vim.notify(
      "`<project_root>/docs` dir not found. Check `generate()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: jsdoc.open()
--=============================================================================
function M.test_open()
  -- ARRANGE
  vim.notify("Testing `jsdoc.open()`.", vim.log.levels.INFO)

  -- ACT
  jsdoc.open()
  vim.wait(ms)

  -- ASSERT (This step is currently visually asserted)
  vim.notify(
    "Please, check on your internet browser that jsdoc opened correctly.",
    vim.log.levels.WARN)
end


-- RUN TESTS
--=======================================================================
M.test_auto_setup()
M.test_generate()
M.test_open()
