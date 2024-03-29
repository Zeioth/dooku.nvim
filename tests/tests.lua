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
local examples_dir = utils.os_path((debug.getinfo(1, 'S').source:sub(2):match '(.*/)') .. "examples/")
local tests_dir = utils.os_path((debug.getinfo(1, 'S').source:sub(2):match '(.*/)') .. "tests/")

-- Disable default opts
local config = require("dooku.config")
config.set({ on_generate_open = false })

-- Clean
vim.fn.chdir(examples_dir)
io.popen("git clean -xdf .")
vim.wait(1000)

-- Run tests
dofile(tests_dir .. 'doxygen.lua')
dofile(tests_dir .. 'rustdoc.lua')
dofile(tests_dir .. 'godoc.lua')
dofile(tests_dir .. 'typedoc.lua')
dofile(tests_dir .. 'jsdoc.lua')
dofile(tests_dir .. 'ldoc.lua')
