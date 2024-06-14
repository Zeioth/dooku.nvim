--- Test suite for dooku.nvim
--- @usage :luafile ~/.local/share/nvim/lazy/dooku.nvim/tests/tests.lua
--
-- HOW TO OPEN THE TESTS LOG
--   * Assuming you use nvim-notify run:
--   :lua require("telescope").extensions.notify.notify()
--
-- EXPECTED RESULT
--   * A webpage per test file will open in your internet browser.
--   * If a test fail to pass, you will get a nvim notification.


local utils = require("dooku.utils")
local examples_dir = utils.get_dooku_dir("tests/code samples/")
local tests_dir = utils.get_dooku_dir("tests/tests/")
local ms = 6000

-- Disable default opts
local config = require("dooku.config")
config.set({ on_generate_open = false })

-- Clean
vim.fn.chdir(examples_dir)
io.popen("git clean -xdf .")

-- Run tests
coroutine.resume(coroutine.create(function()
  local co = coroutine.running()
  local function sleep(_ms)
    if not _ms then _ms = ms end
    vim.defer_fn(function() coroutine.resume(co) end, _ms)
    coroutine.yield()
  end

  sleep()
  dofile(tests_dir .. 'doxygen.lua')
  sleep()
  dofile(tests_dir .. 'rustdoc.lua')
  sleep()
  dofile(tests_dir .. 'godoc.lua')
  sleep()
  dofile(tests_dir .. 'typedoc.lua')
  sleep()
  dofile(tests_dir .. 'jsdoc.lua')
  sleep()
  dofile(tests_dir .. 'ldoc.lua')
  sleep()
  dofile(tests_dir .. 'yard.lua')
end))
