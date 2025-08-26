# Dotfiles
This is my personal configuration for code in terminal. Including wezterm, zsh, nvim and tmux.

## Requirements
- [ohmyz](https://ohmyz.sh)
- [neovim 0.8+](https://neovim.io) 
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts#font-installation)
- [Lazy Git](https://github.com/jesseduffield/lazygit)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

or you can see: [Brewfile](https://github.com/cicingik/dotfiles/blob/main/homebrew/Brewfile).

## Installation

### Available Commands
```bash
mkdir ~/personal -p
cd ~/personal
git clone https://github.com/cicingik/dotfiles.git
cd dotfiles

./install.sh help

cicingik dotfiles
==============================

Usage: ./install.sh <command>

Available commands:
wezterm : Setup wezterm; overide all existing configuration.
zsh     : Setup zsh; overide all existing configuration.
nvim    : Setup nvim; overide all existing configuration.
tmux    : Setup tmux; overide all existing configuration.
all     : Setup all dottfile config; overide all existing configuration.

NOTE: Old configuration will be back up in directory ~/dotfiles-backup
```
