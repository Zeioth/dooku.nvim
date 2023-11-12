# dooku.nvim
Generate and open your HTML code documentation inside Neovim.

<div align="center">
  <a href="https://discord.gg/ymcMaSnq7d" rel="nofollow">
      <img src="https://img.shields.io/discord/1121138836525813760?color=azure&labelColor=6DC2A4&logo=discord&logoColor=black&label=Join the discord server&style=for-the-badge" data-canonical-src="https://img.shields.io/discord/1121138836525813760">
    </a>
</div>

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

* These options can be accessed in execution time with `vim.g.dooku_config`.
* We also expose [advanced options](https://github.com/Zeioth/dooku.nvim/wiki/advanced_options) to control how the plugin work internally.

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

## Roadmap
We could add better QA

* Better troubleshooting section.
* If no backend is detected, notify the user.
* We could poll for a a period of time after `DookuGenerate` before timeout, so it is not necessary to run `DookuGenerate` two times the first time you use it on a project.
* If no project_root detected, and we reach the user directory, report to the user `project_root not found. Make sure you have on of the files defined in the option in your root directory`. Alternatevily we could just wipe project_root and take the current working directory as default root, so it is more intuitive.

