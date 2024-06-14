--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/doxygen.lua

local M = {}
local utils = require("dooku.utils")

local ms = 2000 -- wait time
local doxygen = require("dooku.backends.doxygen")
local example_dir = utils.get_dooku_dir("tests/code samples/doxygen/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Doxygen backend", vim.log.levels.INFO)


coroutine.resume(coroutine.create(function()
  local co = coroutine.running()
  local function sleep(_ms)
    if not _ms then _ms = ms end
    vim.defer_fn(function() coroutine.resume(co) end, _ms)
    coroutine.yield()
  end

  -- TEST: doxygen.auto_setup()
  --===========================================================================
  function M.test_auto_setup()
    -- ARRANGE
    vim.notify("Testing `doxygen.auto_setup()`.", vim.log.levels.INFO)

    -- ACT
    doxygen.auto_setup()
    sleep()

    -- ASSERT
    local config_generated_ok = vim.fn.isdirectory(
      utils.get_dooku_dir("tests/code samples/doxygen/doxygen/")) == 1
    if config_generated_ok == false then
      vim.notify("`<project_roo>/doxygen/` dir not found. Check `setup()` in the backend.",
        vim.log.levels.ERROR)
    end
  end


  -- TEST: doxygen.generate()
  --===========================================================================
  function M.test_generate()
    -- ARRANGE
    vim.notify("Testing `doxygen.generate(false)`.", vim.log.levels.INFO)

    -- ACT
    doxygen.generate(false)
    sleep()

    -- ASSERT
    local docs_generated_ok = vim.fn.isdirectory(
      utils.get_dooku_dir("tests/code samples/doxygen/doxygen/html/")) == 1
    if docs_generated_ok == false then
      vim.notify(
        "`<project_roo>/doxygen/html/` dir not found. Check `generate()` in the backend.",
        vim.log.levels.ERROR)
    end
  end


  -- TEST: doxygen.open()
  --===========================================================================
  function M.test_open()
    -- ARRANGE
    vim.notify("Testing `doxygen.open()`.", vim.log.levels.INFO)

    -- ACT
    doxygen.open()
    sleep()

    -- ASSERT (This step is currently visually asserted)
    vim.notify(
      "Please, check on your internet browser that doxygen opened correctly.",
      vim.log.levels.WARN)
  end


  -- RUN TESTS
  --===========================================================================
  M.test_auto_setup()
  M.test_generate()
  M.test_open()

end))
