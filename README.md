# dooku.nvim
Generate and open your HTML code documentation inside Neovim.

![screenshot_2023-08-07_18-56-31_067791379](https://github.com/Zeioth/dooku.nvim/assets/3357792/6e601100-7886-43d3-b15d-f104c2329974)
<div align="center">
  <a href="https://discord.gg/ymcMaSnq7d" rel="nofollow">
      <img src="https://img.shields.io/discord/1121138836525813760?color=azure&labelColor=6DC2A4&logo=discord&logoColor=black&label=Join the discord server&style=for-the-badge" data-canonical-src="https://img.shields.io/discord/1121138836525813760">
    </a>
</div>

## Table of contents

- [Why](#why)
- [Should I use doge or dooku?](#should-i-use-doge-or-dooku)
- [Supported languages](#supported-languages)
- [Required system dependencies](#required-system-dependencies)
- [How to install](#how-to-install)
- [Commands](#commands)
- [Options](#options)
- [Basic usage](#basic-usage)
- [FAQ](#faq)

## Why
To setup, generate, and open your HTML code documentation with a single key press.

## Should I use doge or dooku?

* [What is vim-doge](https://github.com/kkoomen/vim-doge): Helper to write code comments inside your code.
* [What is dooku.nvim](https://github.com/Zeioth/dooku.nvim): It generates the actual `html` documentation, and open it on your internet browser. Depending the language it will use `doxygen`, `typedoc`, `jsdoc`, `rustdoc`, `godoc`, or any other.

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

## Required system dependencies
```sh
# Pacman is arch linux package manager.
# Use the equivalent command for your distro.
sudo pacman -S doxygen rust go
npm install -g typedoc jdoc
go install golang.org/x/tools/cmd/godoc@latest
```
Then run `:checkhealth dooku` to check if everything is OK.

## How to install
lazy.nvim
```lua
{
  "Zeioth/dooku.nvim",
  event = "VeryLazy",
  opts = {
    -- your config options here
  },
},
```

## Commands
| Command | Description|
|--|--|
| `:DookuAutoSetup` | It will download a config file in your project root directory, so you can run `:DookuGenerate` without having to configure anything. Not necessary for `rust` and `go`. |
| `:DookuGenerate` | Generate the HTML documentation using the adecuated generator for the current filetype. |
| `:DookuOpen` | Open the HTML documentation using the specified program, or the default internet browser. |

## Options
```lua
project_root = { '.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout' } -- when one of these files is found, consider the directory the project root. Search starts from the current buffer.
on_bufwrite_generate = true  -- auto run :DookuGenerate when a buffer is written.
on_generate_open = true      -- auto open when running :DookuGenerate. This options is not triggered by on_bufwrite_generate.

auto_setup = true            -- auto download a config for the generator if it doesn't exist in the project.
browser_cmd = "xdg-open"     -- write your internet browser here. If unset, it will attempt to detect it automatically.

-- notifications
on_generate_notification = true
on_open_notification = true
```

* (Optional) These options can be accessed from anywhere with `vim.g.dooku_config`.
* (Optional) We also expose [advanced options](https://github.com/Zeioth/dooku.nvim/wiki/advanced_options) to control how the plugin work internally.

## Basic usage
Run the commands in this order

* `:DookuAutoSetup`
* `:DookuGenerate`
* `:DookuOpen`

Or if you prefer run `:DookuGenerate` repeteadly until your see the docs. This is possible because by default the options `auto_setup` and `on_generate_open` are `true`.

## FAQ
* **Doesn't work?** Make sure you have installed the [required dependencies](https://github.com/Zeioth/dooku.nvim/edit/main/README.md#required-dependencies)
* **Still doesn't work?** If you are on `rust / go` you must initialize your project with any of these commands `cargo new your_project_name` or `go mod init your_module_name`.
* **STILL doesn't work?** Then congratulations, you found a bug. Please [report it here](https://github.com/Zeioth/dooku.nvim/issues) so I can fix it.
* **Where do that cheesy name come from?** From [Star Wars](https://starwars.fandom.com/wiki/Dooku).
* **Is this plugin based on some other** This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).
* **How can I add support for a new language?** On the `backends` directory, copy the file `doxygen.lua`, and and use it as base to add your new documentation generator. On `options.lua`, copy all the doxygen specific options, and rename them to the language you are adding. Finally, on `commands.lua`, add your language to the if condition of the functions `generate`, `open`, and `auto_setup`, so your backend is recognized and loaded. Don't forget to send your PR so everyone can benefit from it!

## Roadmap
We could add better QA

* If no project_root detected, and we reach the user directory, report to the user `project_root not found. Make sure you have one of the files defined in the option in your root directory`. Alternatevily we could just wipe project_root and take the current working directory as default root, so it is more intuitive.

