# Nvim setup with support for Flutter/Dart
Prerequisites: Neovim 0.12+, [ripgrep](https://github.com/BurntSushi/ripgrep), [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) and a C compiler (for treesitter parsers): `brew install neovim ripgrep tree-sitter-cli`.

AI completion uses Neovim's built-in inline completion with Copilot (installed through mason). Sign in once with `:LspCopilotSignIn`, toggle with `:AIToggle` / `<leader>cp`.

## This setup has my personal keybinds.
**Feel free to switch, tweak or remove as you see fit!**

As it contains some personal setup, some keybinds might also be for scripts, all scripts area available in my [.dotfiles/bin/.local/bin](https://github.com/RobertBrunhage/.dotfiles/tree/main/bin/.local/bin)

### Important to be aware of

1. The file that neovim loads first is `init.lua`, this loads `lua/me/*`
2. For plugins we are using Lazy so you can either create an entry in `lua/plugins.lua` or add a file in `lua/plugins/{}`
