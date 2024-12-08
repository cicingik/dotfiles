# Dotfiles
This is my personal configuration for code in terminal. Including nvim, zsh, and wezterm.

## Requirements
- [ohmyz](https://ohmyz.sh)
- [neovim 0.8+](https://neovim.io) 
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts#font-installation)
- [Lazy Git](https://github.com/jesseduffield/lazygit)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Installation

### Available Commands
```bash
mkdir ~/personal -p
cd ~/personal
git clone https://github.com/cicingik/dotfiles.git
cd dotfiles

./install.sh help

Usage: ./install.sh <command>

Available commands:
all   : Setup all dottfile config; overide all existing configuration.
nvim  : Setup nvim; overide all existing configuration.
```
