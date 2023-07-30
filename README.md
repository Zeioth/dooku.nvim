# dooku.nvim
Generate and open your code documentation inside NeoVim.

## What documentation plugin should I use?
Often, people wonder what documentation plugin they should use. Their purpose is quite different:

* Doge.vim: Helper to write code comments inside your code.
* Dooku.nvim: It generates the actual `html` documentation, and open it on your internet browser. Depending the language it will use `Doxygen`, `typedoc`, `rustdoc`, `godoc`, or any other.


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
| `javascript` | jdoc |
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

## How to use

## Recommended mappings

## Available commands

## Configuration options

## Credits
This is a lua port of the vim plugin [vim-dooku](https://github.com/Zeioth/vim-dooku).

## Roadmap
* MVP: doxygen
* Port the other backends: jdoc, typedoc, rustdoc, godoc
* Porting the manual from vim-doooku, so we can use :help dooku
* Writing health file, so we can check if dependencies are fulfilled.
