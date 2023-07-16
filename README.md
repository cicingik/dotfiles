# Dotfiles
This is my personal configuration for code in terminal. Including tmux, nvim, omyz, and alacritty.

## Requirements
- [ohmyz](https://ohmyz.sh)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
- [neovim 0.8+](https://neovim.io) 
- [Nerd Font](https://github.com/ryanoasis/nerd-fonts#font-installation)

## Installation

### Available Commands
```bash
Usage: ./install.sh <command>

Info: Available commands:
all   : Setup nvim and zsh; overide all existing configuration.
nvim  : Setup nvim; overide all existing configuration.
```

### tmux plugins

```
prefix C-a
```

just open `tmux` for auto install all needed plugins
```bash
tmux
```

and press `prefix + I` to fetch the plugin and source it. Done.
