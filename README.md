# dooku.nvim
Generate and open your HTML code documentation inside Neovim.

## Should I use doge or dooku?
Their purpose is quite different:

* [vim-doge](https://github.com/kkoomen/vim-doge): Helper to write code comments inside your code.
* [dooku.nvim](https://github.com/Zeioth/dooku.nvim): It generates the actual `html` documentation, and open it on your internet browser. Depending the language it will use `doxygen`, `typedoc`, `jsdoc`, `rustdoc`, `godoc`, or any other.

![screenshot_2023-08-07_18-56-31_067791379](https://github.com/Zeioth/dooku.nvim/assets/3357792/6e601100-7886-43d3-b15d-f104c2329974)

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
| `typescript` | typedoc |
| `javascript` | jsdoc |
| `rust` | rustdoc |
| `go`| godoc |

# Not supported yet
Pull requests are welcome.

| Language | Generator |
|--|--|
| `lua` | ldoc |
| `ruby` | yard |

## Required dependencies
You need the dependencies in order for `dooku.nvim` to be able to call the documentation generators. In this example I install them on Arch Linux using `pacman`, and `npm`, but you can find them on any operative system.
```sh
sudo pacman -S doxygen rust go
npm install -g typedoc jdoc
go install golang.org/x/tools/cmd/godoc@latest
```
To check if all the dependencies are correctly installed, run `lua require("dooku")` to ensure the plugin is loaded, and then `:checkhealth dooku`. 

If you've installed the dependencies, but `:checkhealth dooku` still show warnings, that means your executables were not correctly added to your path. Make sure you can manually run the commands `doxygen`, `typedoc`, `jsdoc`, `cargo`, and `godoc` on the terminal.

## How to install
This example is for the lazy.nvim package manager.
```lua
{
  "Zeioth/dooku.nvim",
  cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
  opts = {
    -- your config options here
  },
},
```
## How to use
Use `:DookuGenerate` to generate the html documentation of your project. Then `:DookuOpen` to open it on your internet browser. 

By default the option `auto_setup` is enabled, so you won't have to manually setup the documentation for your project. If you prefer to do it manually, disable this option.

## Recommended mappings
```lua
vim.api.nvim_buf_set_keymap(0, 'n', '<F1>', "<cmd>DookuGenerate<cr>", { noremap = true, silent = true })
```

## Available commands
| Command | Description|
|--|--|
| `:DookuGenerate` | Generate the HTML documentation using the adecuated generator for the current filetype. |
| `:DookuOpen` | Open the HTML documentation using the specified program, or the default internet browser. |
| `:DookuAutoSetup` | It will download a config file in your project root directory, so you can run `:DookuGenerate` without having to configure anything. Not necessary for `rust` and `go`. |

## Basic configuration options
```lua
-- General settings
project_root = { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' } -- when one of these files is found, consider the directory the project root. Search starts from the current buffer.
on_generate_notification = true
on_open_notification = true
on_bufwrite_generate = true  -- auto run :DookuGenerate when a buffer is written.
on_generate_open = true      -- auto open when running :DookuGenerate. This options is not triggered by on_bufwrite_generate.
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
typedoc_docs_dir = "docs"                                                        -- the typedoc dir.
typedoc_html_file = "index.html"                                                 -- html file to open with :DookuOpen. This path starts in typedoc_docs_dir, instead of the root directory.
typedoc_clone_config_repo = "https://github.com/Zeioth/vim-typedoc-template.git" -- repo to clone if auto_setup.
typedoc_clone_to_dir = "vim-typedoc-template"                                    -- clone into this dir.
typedoc_clone_cmd_post = ""                                                      -- runs a command after cloning. If you set this option manually, make sure you copy 'typedoc.json' from 'typedoc_clone_to_dir', into the root directory here.

-- jsdoc specific settings
jsdoc_filetypes = { "javascript" }                                             -- for this filetypes use jsdoc
jsdoc_docs_dir = "docs"                                                        -- the typedoc dir.
jsdoc_html_file = "index.html"                                                 -- html file to open with :DookuOpen. This path starts in jsdoc_docs_dir, instead of the root directory.
jsdoc_clone_config_repo = "https://github.com/Zeioth/vim-jsdoc-template.git"   -- repo to clone if auto_setup.
jsdoc_clone_to_dir = "vim-typedoc-template"                                    -- clone into this dir.
jsdoc_clone_cmd_post = ""                                                      -- runs a command after cloning. If you set this option manually, make sure you copy 'typedoc.json' from 'typedoc_clone_to_dir', into the root directory here.

-- rustdoc specific settings
rustdoc_filetypes = { "rust" }                                                 -- for this filetypes use rustdoc
rustdoc_docs_dir = "target/doc"                                                -- the rustdoc dir. for rust, this options is only for opening the docs. If you want to change the location where the target directory is created, use the option cargo_rustdoc_args.
rustdoc_html_file = "index.html"                                               -- html file to open with :DookuOpen. This path starts in rustdoc_docs_dir/crate_name, instead of the root directory. crate_name value will be the name of the project root.
cargo_rustdoc_args = ""                                                        -- optional args to pass after "cargo rustdoc". They will be passed as "cargo rustdoc cargo_rustdoc_args -- rustdoc_args"
rustdoc_args = ""                                                              -- optional rustdoc args to pass after "cargo rustdoc". They will be passed as "cargo rustdoc cargo_rustdoc_args -- rustdoc_args". WARNING: Be aware some rustdoc_args do not work correctly and will cause failure. This is a rust thing, not ours. It's a good idea to always run the command manually on the terminal to check if it works correctly with the arguments you are trying to pass before passing them here. That way you can debug it easier.

-- godoc specific settings
godoc_filetypes = { "go" }                                                     -- for this filetypes use godoc.
godoc_html_url = "localhost:6060"                                              -- url of the godoc server to open with :DookuOpen. When you use :DookuGenerate at least once, the godoc server will keep running until neovin is closed (unless you manually kill the godoc process first).
godocdoc_args = ""                                                             -- optional args to pass to the command "godoc". If you change the url, make sure to also change it on godoc_html_url.
```

## Troubleshooting
If you have the option `auto_setup` enabled, and you are running `:DookuGenerate` on your project for the first time, you will have to run the command two times. One for auto setup to kick in, and a second one to actually generate the docs.

If you have the option `on_generate_open` enabled, and it's your first time running `:DookuGenerate` on a project, you will have to run `:DookuGenerate` twice. One for generating the docs, and another one to open them.

This is only necessary the first time, and the reason is we run all tasks asynchronously.

## FAQ
* **How can I add support for a new language?** On the `backends` directory, copy the file `doxygen.lua`, and and use it as base to add your new documentation generator. On `options.lua`, copy all the doxygen specific options, and rename them to the language you are adding. Finally, on `commands.lua`, add your language to the if condition of the functions `generate`, `open`, and `auto_setup`, so your backend is recognized and loaded. Don't forget to send your PR so everyone can benefit from it!
* **(ADVANCED) Explain `:DookuAutoSetup` to me in detail**: All this command do is to clone a repo `clone_config_repo` into a dir `clone_to_dir` inside your project root, and then run a command `clone_cmd_post` to copy the files from the cloned repo to another location, if needed. Normally you don't need to touch any of these options.

## Credits
This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).

## Where do that cheesy name come from?
From [Star Wars](https://starwars.fandom.com/wiki/Dooku).
