--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/godoc.lua

local M = {}
local utils = require("dooku.utils")

local ms = 2000 -- wait time
local godoc = require("dooku.backends.godoc")
local example_dir = utils.get_dooku_dir("tests/code samples/go/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Godoc backend", vim.log.levels.INFO)


coroutine.resume(coroutine.create(function()
  local co = coroutine.running()
  local function sleep(_ms)
    if not _ms then _ms = ms end
    vim.defer_fn(function() coroutine.resume(co) end, _ms)
    coroutine.yield()
  end

  -- TEST: godoc.auto_setup()
  --===========================================================================
  function M.test_auto_setup()
    -- ARRANGE
    vim.notify("Testing `godoc.auto_setup()`.", vim.log.levels.INFO)

    -- ACT
    godoc.auto_setup()
    sleep()
  end


  -- TEST: godoc.generate()
  --===========================================================================
  function M.test_generate()
    -- ARRANGE
    vim.notify("Testing `godoc.generate(false)`.", vim.log.levels.INFO)

    -- ACT
    godoc.generate(false)
    sleep()
  end


  -- TEST: godoc.open()
  --===========================================================================
  function M.test_open()
    -- ARRANGE
    vim.notify("Testing `godoc.open()`.", vim.log.levels.INFO)

    -- ACT
    godoc.open()
    sleep()

    -- ASSERT (This step is currently visually asserted)
    vim.notify(
      "Please, check on your internet browser that godoc opened correctly.",
      vim.log.levels.WARN)
  end


  -- RUN TESTS
  --===========================================================================
  M.test_auto_setup()
  M.test_generate()
  M.test_open()
end))
