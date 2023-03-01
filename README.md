# dotfiles
personal configuration

## pre-required
- [ohmyz](https://ohmyz.sh)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
- [neovim 0.8+](https://neovim.io) 
- Nerd Font
  ```bash
  brew install --cask font-hack-nerd-font
  ```

## installation
```bash
-- backup existing .zshrc
mv .zshrc .zshrc.bak

ln -s -f dotfiles/zsh/.zshrc
ln -s -f dotfiles/tmux/.tmux.conf
ln -s -f dotfiles/tmux/.tmux.conf.local

cp -rf dotfiles/nvim .config/nvim
```