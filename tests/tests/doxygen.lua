--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/doxygen.lua

local M = {}
local ms = 1000 -- wait time
local doxygen = require("dooku.backends.doxygen")
local example_dir = require("dooku.utils").get_dooku_dir("tests/examples/doxygen/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Doxygen backend", vim.log.levels.INFO)


-- TEST: doxygen.auto_setup()
--=============================================================================
function M.test_auto_setup()
  -- ARRANGE
  vim.notify("Testing `doxygen.auto_setup()`.", vim.log.levels.INFO)

  -- ACT
  doxygen.auto_setup()
  vim.wait(ms)

  -- ASSERT
  local config_generated_ok = vim.fn.isdirectory(
    require("dooku.utils").get_dooku_dir(
      "tests/examples/doxygen/doxygen/")) == 1
  if config_generated_ok == false then
    vim.notify("`doxygen` dir not found. Check `setup()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: doxygen.generate()
--=============================================================================
function M.test_generate()
  -- ARRANGE
  vim.notify("Testing `doxygen.generate(false)`.", vim.log.levels.INFO)

  -- ACT
  doxygen.generate(false)
  vim.wait(ms)

  -- ASSERT
  local docs_generated_ok = vim.fn.isdirectory(
    require(
      "dooku.utils").get_dooku_dir("tests/examples/doxygen/doxygen/html")) == 1
  if docs_generated_ok == false then
    vim.notify("`doxygen/html` dir not found. Check `generate()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: doxygen.open()
--=============================================================================
function M.test_open()
  -- ARRANGE
  vim.notify("Testing `doxygen.open()`.", vim.log.levels.INFO)

  -- ACT
  doxygen.open()
  vim.wait(ms)

  -- ASSERT (This step is currently visually asserted)
  vim.notify(
    "Please, check on your internet browser that doxygen opened correctly.",
    vim.log.levels.WARN)
end


-- RUN TESTS
--=======================================================================
M.test_auto_setup()
M.test_generate()
M.test_open()

