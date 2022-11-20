# Lf.lua

A simple [Lf](https://github.com/gokcehan/lf) wrapper for Neovim.

Also check [lf.vim](https://github.com/gboncoffee/lf.vim), a VimScript Lf
wrapper that works in Vim too.

## Installing

Install it with your favorite package manager.

## Usage

The command `Lf` opens the Lf file manager inside the Neovim native terminal, in
a floating window. Opening a file inside Lf will make it to quit and open the
same file inside Neovim.

By default, the Neovim `cwd` will **NOT** change to the last directory of Lf.
This behaviour can be changed in the setup, or, if you want to change it only
once, using the commands `LfChangeCwd` and `LfNoChangeCwd`.

## Setup

```lua
require "lf".setup {
    default_cwd    = false, -- true or false, defaults false
    change_cwd_cmd = "cd",  -- Neovim command to change cwd ("cd", "tcd", "lcd")
}
```
