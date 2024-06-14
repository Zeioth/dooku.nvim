--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests/ldoc.lua

local M = {}
local utils = require("dooku.utils")

local ms = 2000 -- wait time
local ldoc = require("dooku.backends.ldoc")
local example_dir = utils.get_dooku_dir("tests/code samples/lua/")

vim.fn.chdir(example_dir) -- set working_dir
vim.notify("TESTING: Ldoc backend", vim.log.levels.INFO)


coroutine.resume(coroutine.create(function()
  local co = coroutine.running()
  local function sleep(_ms)
    if not _ms then _ms = ms end
    vim.defer_fn(function() coroutine.resume(co) end, _ms)
    coroutine.yield()
  end

  -- TEST: ldoc.auto_setup()
  --===========================================================================
  function M.test_auto_setup()
    -- ARRANGE
    vim.notify("Testing `ldoc.auto_setup()`.", vim.log.levels.INFO)

    -- ACT
    ldoc.auto_setup()
    sleep()
  end


  -- TEST: ldoc.generate()
  --===========================================================================
  function M.test_generate()
    -- ARRANGE
    vim.notify("Testing `ldoc.generate(false)`.", vim.log.levels.INFO)

    -- ACT
    ldoc.generate(false)
    sleep()
  end


  -- TEST: ldoc.open()
  --===========================================================================
  function M.test_open()
    -- ARRANGE
    vim.notify("Testing `ldoc.open()`.", vim.log.levels.INFO)

    -- ACT
    ldoc.open()
    sleep()

    -- ASSERT (This step is currently visually asserted)
    vim.notify(
      "Please, check on your internet browser that ldoc opened correctly.",
      vim.log.levels.WARN)
  end


  -- RUN TESTS
  --===========================================================================
  M.test_auto_setup()
  M.test_generate()
  M.test_open()
end))
