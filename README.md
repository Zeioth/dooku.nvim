# dooku.nvim
Generate and open your code documentation inside NeoVim.

## What documentation plugin should I use?

* Doge.vim: Helps you to write code comments inside your comments.
* Dooku.nvim: It generates the actual `html` documentation, and open it on the browser. Depending the language it will use `Doxygen`, `typedoc`, `rustdoc`, `godoc`, or any other.

## Supported languages 

| Language | Generator |
|--|--|
| `c` | doxygen |
| `c++` | doxygen |
| `c# `| doxygen |
| `java` | doxygen | 
| `objetive-c` | doxygen |
| `python` | doxygen |
| `php` | doxygen |
| `javascript` | jdoc |
| `typescript` | typedoc |
| `rust` | rustdoc |
| `go`| godoc |

## Required dependencies
In this example I install them on arch, but you can find them on any distro
```
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
This is a lua port of the vim plugin [dooku.vim](https://github.com/Zeioth/vim-dooku).
