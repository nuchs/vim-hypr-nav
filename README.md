# vim-hypr-nav

Seamless navigation between [hyprland](https://hyprland.org/) windows and (Neo)Vim splits with the same key bindings.

Shamelessly hacked from [vim-sway-nav](https://git.sr.ht/~jcc/vim-sway-nav).

## Requirements

- Vim built with `+clientserver` (check with `vim --version`), or Neovim
- [jq](https://github.com/stedolan/jq)

## Installation

First, install this repository as a Vim plugin. For example, if you use [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug "nuchs/vim-hypr-nav"
```

Then, modify your Sway config to use `vim-hypr-nav` instead of your normal `focus left`, `focus down`, etc. bindings:

```
bind = $mainMod, $left, exec vim-hypr-nav, l
bind = $mainMod, $right, exec vim-hypr-nav, r
bind = $mainMod, $up, exec vim-hypr-nav, u
bind = $mainMod, $down, exec vim-hypr-nav, d
```

You can now use `$mod+<direction>` to navigate among Hyprland windows and Vim splits!

