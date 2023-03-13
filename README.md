# dotfiles
personal configuration

## pre-required
- [ohmyz](https://ohmyz.sh)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
- [neovim 0.8+](https://neovim.io) 
- Nerd Font
  ```bash
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  ```

## installation
```bash
-- clone the repository
git clone https://github.com/cicingik/dotfiles.git
cd dotfiles

-- backup existing .zshrc if exist
mv .zshrc .zshrc.bak

--backup tmux conf if exist

ln -s -f dotfiles/zsh/.zshrc
ln -s -f dotfiles/tmux/.tmux.conf
ln -s -f dotfiles/tmux/.tmux.conf.local

cp -rf dotfiles/nvim .config/nvim
```
