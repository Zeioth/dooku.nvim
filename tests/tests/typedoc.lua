--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/typedoc.lua

local M = {}
local ms = 2000 -- wait time
local typedoc = require("dooku.backends.typedoc")
local example_dir = require("dooku.utils").get_dooku_dir("tests/examples/typescript/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: typedoc backend", vim.log.levels.INFO)


-- TEST: typedoc.auto_setup()
--=============================================================================
function M.test_auto_setup()
  -- ARRANGE
  vim.notify("Testing `typedoc.auto_setup()`.", vim.log.levels.INFO)

  -- ACT
  typedoc.auto_setup()
  vim.wait(ms)

  -- ASSERT
  local config_generated_ok = vim.fn.filereadable(
    require("dooku.utils").get_dooku_dir("tests/examples/typescript/")
      .. "typedoc.json"
  ) == 1
  if config_generated_ok == false then
    vim.notify("`<project_root>/typedoc.json` file not found. Check `auto_setup()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: typedoc.generate()
--=============================================================================
function M.test_generate()
  -- ARRANGE
  vim.notify("Testing `typedoc.generate(false)`.", vim.log.levels.INFO)

  -- ACT
  typedoc.generate(false)
  vim.wait(ms)

  -- ASSERT
  local docs_generated_ok = vim.fn.isdirectory(
    require("dooku.utils").get_dooku_dir("tests/examples/typescript/docs/")
  ) == 1
  print(docs_generated_ok)
  if docs_generated_ok == false then
    vim.notify("`<project_root>/docs` dir not found. Check `generate()` in the backend.",
      vim.log.levels.ERROR)
  end
end


-- TEST: typedoc.open()
--=============================================================================
function M.test_open()
  -- ARRANGE
  vim.notify("Testing `typedoc.open()`.", vim.log.levels.INFO)

  -- ACT
  typedoc.open()
  vim.wait(ms)

  -- ASSERT (This step is currently visually asserted)
  vim.notify(
    "Please, check on your internet browser that typedoc opened correctly.",
    vim.log.levels.WARN)
end


-- RUN TESTS
--=======================================================================
M.test_auto_setup()
M.test_generate()
M.test_open()
