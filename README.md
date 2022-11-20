# vim-sway-nav

**[jasoncarloscox.com/creations/vim-sway-nav](https://jasoncarloscox.com/creations/vim-sway-nav/)**

Seamless navigation between [Sway](https://swaywm.org/) windows and (Neo)Vim splits with the same key bindings.

Inspired by [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).

## Requirements

- Vim built with `+clientserver` (check with `vim --version`), or Neovim
- [jq](https://github.com/stedolan/jq)

## Installation

First, install this repository as a Vim plugin. For example, if you use [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug REPO " TODO
```

Second, download the [`vim-sway-nav` script](TODO) and stick it somewhere in your `$PATH`.

Finally, modify your Sway config to use `vim-sway-nav` instead of your normal `focus left`, `focus down`, etc. bindings:

```
bindsym $mod+$left exec vim-sway-nav left
bindsym $mod+$down exec vim-sway-nav down
bindsym $mod+$up exec vim-sway-nav up
bindsym $mod+$right exec vim-sway-nav right
```

You can now use `$mod+<arrow>` to navigate among Sway windows and Vim splits!

## Contributing

Contributions are welcome! You can send questions, bug reports, patches, etc. by email to [~jcc/public-inbox@lists.sr.ht](https://lists.sr.ht/~jcc/public-inbox). (Don't know how to contribute via email? Check out the interactive tutorial at [git-send-email.io](https://git-send-email.io), or [email me](mailto:me@jasoncarloscox.com) for help.)
