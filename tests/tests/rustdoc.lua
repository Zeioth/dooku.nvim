--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/rustdoc.lua

local M = {}
local utils = require("dooku.utils")

local ms = 2000 -- wait time
local rustdoc = require("dooku.backends.rustdoc")
local example_dir = utils.get_dooku_dir("tests/code samples/rust/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Rustdoc backend", vim.log.levels.INFO)


coroutine.resume(coroutine.create(function()
  local co = coroutine.running()
  local function sleep(_ms)
    if not _ms then _ms = ms end
    vim.defer_fn(function() coroutine.resume(co) end, _ms)
    coroutine.yield()
  end

  -- TEST: rustdoc.auto_setup()
  --===========================================================================
  function M.test_auto_setup()
    -- ARRANGE
    vim.notify("Testing `rustdoc.auto_setup()`.", vim.log.levels.INFO)

    -- ACT
    rustdoc.auto_setup()
    sleep()

    -- ASSERT
    local config_generated_ok = vim.fn.isdirectory(
      utils.get_dooku_dir(
        "tests/code samples/rust/target/doc/")) == 1
    if config_generated_ok == false then
      vim.notify(
        "`<project_root>/target/doc/` dir not found. Check `setup()` in the backend.",
        vim.log.levels.ERROR)
    end
  end


  -- TEST: rustdoc.generate()
  --===========================================================================
  function M.test_generate()
    -- ARRANGE
    vim.notify("Testing `rustdoc.generate(false)`.", vim.log.levels.INFO)

    -- ACT
    rustdoc.generate(false)
    sleep()

    -- ASSERT
    local docs_generated_ok = vim.fn.isdirectory(
      utils.get_dooku_dir("tests/code samples/rust/target/doc/")) == 1
    if docs_generated_ok == false then
      vim.notify(
        "`<project_root>/target/doc` dir not found. Check `generate()` in the backend.",
        vim.log.levels.ERROR)
    end
  end


  -- TEST: rustdoc.open()
  --===========================================================================
  function M.test_open()
    -- ARRANGE
    vim.notify("Testing `rustdoc.open()`.", vim.log.levels.INFO)

    -- ACT
    rustdoc.open()
    sleep()

    -- ASSERT (This step is currently visually asserted)
    vim.notify(
      "Please, check on your internet browser that rustdoc opened correctly.",
      vim.log.levels.WARN)
  end


  -- RUN TESTS
  --===========================================================================
  M.test_auto_setup()
  M.test_generate()
  M.test_open()
end))
