# dooku.nvim
Generate and open your code documentation inside NeoVim.

## What documentation plugin should I use?
Often, people wonder what documentation plugin they should use. Their purpose is quite different:

* [Doge.vim](https://github.com/kkoomen/vim-doge): Helper to write code comments inside your code.
* [Dooku.nvim](https://github.com/Zeioth/dooku.nvim): It generates the actual `html` documentation, and open it on your internet browser. Depending the language it will use `Doxygen`, `typedoc`, `rustdoc`, `godoc`, or any other.


## Supported languages 

| Language | Generator |
|--|--|
| `c` | doxygen |
| `c++` | doxygen |
| `c# `| doxygen |
| `objetive-c` | doxygen |
| `java` | doxygen | 
| `python` | doxygen |
| `php` | doxygen |
| `javascript` | jsdoc |
| `typescript` | typedoc |
| `rust` | rustdoc |
| `go`| godoc |

## Required dependencies
You need the dependencies in order for dooku.nvim to be able to call the documentation generators. In this example I install them on Arch Linux using pacman and yarn, but you can find them on any distro.
```sh
sudo pacman -S doxygen
yarn add global jdoc typedoc
```
You don't need to install rustdoc and godoc as they come included on their respective languages.

## How to instal
lazy.nvim
```lua
{
  "Zeioth/dooku.nvim",
  cmd = { "DookuGen", "DookuOpen" },
  opts = {
    -- your config options here
  }
  config = function(_, opts) require("dooku").setup(opts) end,
},
```
## How to use
Use `:DookuGen` to generate the html documentation of your project. Then `:DookuOpen` to open it on your internet browser. 

By default the option `auto_setup` is enabled, so you won't have to enable the documentation for your project. If you prefer to do it manually, disable this option.

## Recommended mappings
```
-- Dooku generate
vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', "<cmd>DookuGen<cr>", { noremap = true, silent = true })

-- Dooku open
vim.api.nvim_buf_set_keymap(0, 'n', '<S-F6>', "<cmd>DookuOpen<cr>", { noremap = true, silent = true })
```

## Available commands
| Command | Description|
|--|--|
| `:DookuGen` | Generate the HTML documentation using the adecuated generator for the current filetype. |
| `:DookuOpen` | Open the HTML documentation using the specified program, or the default internet browser. |

## Configuration options
```lua
-- General settings
project_root = { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' }
notification_on_generate = true
notification_on_open = true
generate_on_bufwrite = true
on_generate_open = false
auto_setup = true
browser_cmd = "xdg-open"

-- doxygen settings
doxygen_filetypes o { 'c', 'cpp', 'cs', 'python', 'd', 'fortran', 'java', 'perl', 'vhdl', 'objc', 'php' } -- for this filetypes use doxygen
doxygen_html_file = "./html/index.html"                                          -- html file to open with :DookuOpen. You can use a relative, or a full path here.
doxygen_clone_config_repo = "https://github.com/Zeioth/vim-doxygen-template.git" -- repo to clone if auto_setup
doxygen_clone_destiny_dir = "doxygen"                                            -- clone into this dir. You can use a dirname, a relative path, or a full path here.
```

## Credits
This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).

## Roadmap
* ~~MVP: doxygen~~
* Port the other backends: jdoc, typedoc, rustdoc, godoc
* Windows support
* Porting the manual from vim-doooku, so we can use :help dooku
* Writing health file, so we can check if dependencies are fulfilled.
