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
| `javascript` | jsdoc (coming soon) |
| `typescript` | typedoc |
| `rust` | rustdoc  (coming soon) |
| `go`| godoc (coming soon) |

# Not supported yet
Pull requests are welcome.

| Language | Generator |
|--|--|
| `lua` | ldoc |
| `ruby` | yard |

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
  cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
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
vim.api.nvim_buf_set_keymap(0, 'n', '<F2>', "<cmd>DookuGenerate<cr>", { noremap = true, silent = true })

-- Dooku open
vim.api.nvim_buf_set_keymap(0, 'n', '<F3>', "<cmd>DookuOpen<cr>", { noremap = true, silent = true })
```

## Available commands
| Command | Description|
|--|--|
| `:DookuGenerate` | Generate the HTML documentation using the adecuated generator for the current filetype. |
| `:DookuOpen` | Open the HTML documentation using the specified program, or the default internet browser. |
| `:DookuAutoSetup` | It will download a config file in your project root directory, so you can run `:DookuGenerate` without having to configure anything. |

## Basic configuration options
```lua
-- General settings
project_root = { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' } -- when one of these files is found, consider the directory the project root. Search starts from the current buffer.
on_generate_notification = true
on_open_notification = true
on_bufwrite_generate = true  -- auto run :DookuGenerate when a buffer is written.
on_generate_open = false     -- auto open when running :DookuGenerate. This options is not triggered by on_bufwrite_generate.
auto_setup = true            -- auto download a config for the generator if it doesn't exist in the project.
browser_cmd = "xdg-open"     -- write your internet browser here. If unset, it will attempt to detect it automatically.
```

## Advanced configuration options
99% of the time you won't need these advanced options. This is only for people who want more flexibility.

``` lua
-- doxygen specific settings
doxygen_filetypes = { 'c', 'cpp', 'cs', 'python', 'd', 'fortran', 'java', 'perl', 'vhdl', 'objc', 'php' } -- for this filetypes use doxygen
doxygen_docs_dir = "doxygen"                                                     -- the doxigen dir.
doxygen_html_file = "html/index.html"                                            -- html file to open with :DookuOpen. This path starts in doxygen_docs_dir, instead of the root directory.
doxygen_clone_config_repo = "https://github.com/Zeioth/vim-doxygen-template.git" -- repo to clone if auto_setup.
doxygen_clone_to_dir = "doxygen"                                                 -- clone into this dir.
doxygen_clone_cmd_post = ""                                                      -- runs a command after cloning.

-- typedoc specific settings
typedoc_filetypes = { "typescript" }                                             -- for this filetypes use typedoc
doxygen_docs_dir = "docs"                                                        -- the typedoc dir.
typedoc_html_file = "index.html"                                                 -- html file to open with :DookuOpen. This path starts in doxygen_docs_dir, instead of the root directory.
typedoc_clone_config_repo = "https://github.com/Zeioth/vim-typedoc-template.git" -- repo to clone if auto_setup.
typedoc_clone_to_dir = "vim-typedoc-template"                                    -- clone into this dir.
typedoc_clone_cmd_post = ""                                                      -- runs a command after cloning. If you set this option manually, make sure you copy 'typedoc.json' from 'typedoc_clone_to_dir', into the root directory here.
```
## Troubleshooting
If you have the option `auto_setup` enabled, and you are running `:DookuGenerate` on your project for the first time, you will have to run the command two times. One for auto setup to kick in, and a second one to actually generate the docs.

## FAQ
* **(ADVANCED) Explain `:DookuAutoSetup` to me in detail**: All this command do is to clone a repo `clone_config_repo` into a dir `clone_to_dir` inside your project root, and then run a command `clone_cmd_post` to copy the files from the cloned repo to another location, if needed. Normally you don't need to touch any of these options.
* **How can I add support for a new language?** On the `backends` directory, copy the file doxygen.lua, and and use it as base to add your new documentation generator. On `options.lua`, copy all the doxygen specific options, and rename them to the language you are adding. Finally, on `commands.lua`, add your language to the if condition of the functions `generate`, `open`, and `auto_setup`, so your backend is recognized and loaded.

## Credits
This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).

## Roadmap
* ~~MVP: doxygen~~
* ~~Windows support.~~
* Port the other backends: ~~typedoc~~, jsdoc, rustdoc, godoc
* ~~Porting the manual from vim-doooku, so we can use :help dooku.~~
* ~~Writing health file, so we can check if dependencies are fulfilled.~~

## Where do that cheesy name come from?
From [Star Wars](https://starwars.fandom.com/wiki/Dooku).
