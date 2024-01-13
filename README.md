# Nvim setup with support for Flutter/Dart (and DCM)
Prerequisite: install [ripgrep](https://github.com/BurntSushi/ripgrep).

## This setup has my personal keybinds.
**Feel free to switch, tweak or remove as you see fit!**

As it contains some personal setup, some keybinds might also be for scripts, all scripts area available in my [.dotfiles/bin/.local/bin](https://github.com/RobertBrunhage/.dotfiles/tree/main/bin/.local/bin)

### Important to be aware of

1. The file that neovim loads first is `init.lua`, this loads `lua/me/*`
2. For plugins we are using Lazy so you can either create an entry in `lua/plugins.lua` or add a file in `lua/plugins/{}`
