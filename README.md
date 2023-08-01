# dooku.nvim
Generate and open your code documentation inside NeoVim.

## Should I use doge or dooku?
Their purpose is quite different:

* [Doge.vim](https://github.com/kkoomen/vim-doge): Helper to write code comments inside your code.
* [Dooku.nvim](https://github.com/Zeioth/dooku.nvim): It generates the actual `html` documentation, and open it on your internet browser. Depending the language it will use `doxygen`, `typedoc`, `rustdoc`, `godoc`, or any other.


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
You need the dependencies in order for dooku.nvim to be able to call the documentation generators. In this example I install them on Arch Linux using pacman and npm, but you can find them on any distro.
```sh
sudo pacman -S doxygen
npm install -g jdoc typedoc
```
To check if all the dependencies are correctly installed, run `:checkhealth dooku`

## How to instal
lazy.nvim
```lua
{
  "Zeioth/dooku.nvim",
  cmd = { "DookuGenerate", "DookuOpen" },
  opts = {
    -- your config options here
  }
  config = function(_, opts) require("dooku").setup(opts) end,
},
```
## How to use
Use `:DookuGenerate` to generate the html documentation of your project. Then `:DookuOpen` to open it on your internet browser. 

By default the option `auto_setup` is enabled, so you won't have to manually setup the documentation for your project. If you prefer to do it manually, disable this option.

## Recommended mappings
```lua
-- Dooku generate
vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', "<cmd>DookuGenerate<cr>", { noremap = true, silent = true })

-- Dooku open
vim.api.nvim_buf_set_keymap(0, 'n', '<S-F6>', "<cmd>DookuOpen<cr>", { noremap = true, silent = true })
```

## Available commands
| Command | Description|
|--|--|
| `:DookuGenerate` | Generate the HTML documentation using the adecuated generator for the current filetype. |
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
browser_cmd = "xdg-open" -- Write your internet browser here. If unset, it will attempt to detect it automatically.

-- doxygen specific settings
doxygen_filetypes = { 'c', 'cpp', 'cs', 'python', 'd', 'fortran', 'java', 'perl', 'vhdl', 'objc', 'php' } -- for this filetypes use doxygen
doxygen_html_file = "./html/index.html"                                          -- html file to open with :DookuOpen.
doxygen_clone_config_repo = "https://github.com/Zeioth/vim-doxygen-template.git" -- repo to clone if auto_setup
doxygen_clone_destiny_dir = "./doxygen"                                          -- clone into this dir.
```

## Where do that cheesy name come from?
From [Star Wars](https://starwars.fandom.com/wiki/Dooku).

## Credits
This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).

## Roadmap
* ~~MVP: doxygen~~
* ~~Windows support.~~
* Port the other backends: jdoc, typedoc, rustdoc, godoc
* ~~Porting the manual from vim-doooku, so we can use :help dooku.~~
* ~~Writing health file, so we can check if dependencies are fulfilled.~~
