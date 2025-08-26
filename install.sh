#!/usr/bin/env bash

# Variables
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

DOTFILES="$(pwd)"
BACKUP_DIR=$HOME/dotfiles-backup

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

get_linkables() {
    find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'
}

setup_zsh() {
    title "Setting up Zsh"
    mkdir -p "$BACKUP_DIR"

    info "Copy custom theme"
    cp "$DOTFILES/zsh/cicingik.zsh.theme" "$HOME/.oh-my-zsh/themes/zsh.theme"

    for file in $(find -H "$DOTFILES/zsh" -maxdepth 3 -name '*.symlink'); do
        filename=".$(basename "$file" '.symlink')"
        target="$HOME/$filename"
        if [ -f "$target" ]; then
            info "Backing up $filename $BACKUP_DIR/$filename"
            mv "$target" "$BACKUP_DIR"

            info "Creating symlink for $config"
            ln -f -s "$file" "$target"
        else
            warning "$filename does not exist at this location or is a symlink"
            info "Creating symlink for $config"
            ln -f -s "$file" "$target"
        fi
    done

    info "Reloading configuration"
    source "$HOME/.zshrc"
}

setup_wezterm() {
    title "Setting up Wezterm"
    mkdir -p "$BACKUP_DIR"

    config="$DOTFILES/config/wezterm"
    target="$HOME/.config/wezterm"
    if [ ! -L "$target" ]; then
        if [ -d "$target" ]; then
            info "Backing up $target to $BACKUP_DIR/$target"
            mv -f "$target" "$BACKUP_DIR"
        elif [[ -f "$target" ]]; then
            info "Backing up $target to $BACKUP_DIR/$target"
            mv "$target" "$BACKUP_DIR"
        else
            warning "$target does not exist at this location or is a symlink"
            warning "Removing $target"
            rm -rf "$target"
        fi
    else
        warning "$target does not exist at this location or is a symlink"
        warning "removing $target"
        rm -rf "$target"
    fi


    info "Installing Plugin"
    git clone "https://github.com/danielcopper/wezterm-session-manager.git" "$DOTFILES/config/wezterm/wezterm-session-manager"

    echo -e
    info "Installing to ~/.config"
    ln -f -s "$config" "$target"
}

setup_nvim() {
    title "Setting up Nvim"
    mkdir -p "$BACKUP_DIR"

    config="$DOTFILES/config/nvim"
    target="$HOME/.config/nvim"
    if [ ! -L "$target" ]; then
        if [ -d "$target" ]; then
            info "Backing up $target to $BACKUP_DIR/$target"
            mv -f "$target" "$BACKUP_DIR"
        elif [[ -f "$target" ]]; then
            info "Backing up $target to $BACKUP_DIR/$target"
            mv "$target" "$BACKUP_DIR"
        else
            warning "$target does not exist at this location or is a symlink"
            warning "Removing $target"
            rm -rf "$target"
        fi
    else
        warning "$target does not exist at this location or is a symlink"
        warning "removing $target"
        rm -rf "$target"
    fi

    echo -e
    info "Installing to ~/.config"
    ln -f -s "$config" "$target"
}

setup_tmux() {
    title "Setting up Tmux"
    mkdir -p "$BACKUP_DIR"

    for file in $(find -H "$DOTFILES/tmux" -maxdepth 3 -name '*.symlink'); do
        filename=".$(basename "$file" '.symlink')"
        target="$HOME/$filename"
        if [ -f "$target" ]; then
            info "Backing up $filename $BACKUP_DIR/$filename"
            mv "$target" "$BACKUP_DIR"

            info "Creating symlink for $config"
            ln -f -s "$file" "$target"
        else
            warning "$filename does not exist at this location or is a symlink"
            info "Creating symlink for $config"
            ln -f -s "$file" "$target"
        fi
    done
}

all() {
    info "All backup config will store at $BACKUP_DIR"
    warning "Are you sure will overide all config for wezterm, zsh, nvim and tmux? ([Y]es/[N]o)"
    read
    if [[ $REPLY == "y" || $REPLY == "Y" || $REPLY == "Yes" || $REPLY == "yes" ]]; then
        setup_wezterm
        setup_zsh
        setup_nvim
        setup_tmux
    fi
}

help() {
    title "cicingik dotfiles"
    echo -e $"Usage: ./$(basename "$0") <command>\n"
    echo -e "${COLOR_BLUE}Available commands:${COLOR_NONE}$1"
    echo -e $"wezterm : Setup wezterm; overide all existing configuration."
    echo -e $"zsh     : Setup zsh; overide all existing configuration."
    echo -e $"nvim    : Setup nvim; overide all existing configuration."
    echo -e $"tmux    : Setup tmux; overide all existing configuration."
    echo -e $"tmux    : Setup tmux; overide all existing configuration."
    echo -e $"all     : Setup all dotfiles config; overide all existing configuration."

    echo -e "\nNOTE: Old configuration will be back up in directory $BACKUP_DIR"
}

case "$1" in
    zsh)
        setup_zsh
        ;;
    wezterm)
        setup_wezterm
        ;;
    nvim)
        setup_nvim
        ;;
    tmux)
        setup_tmux
        ;;
    all)
        all
        ;;
    help)
        help
        exit 0
        ;;
    *)
        help
        exit 1
        ;;
esac

echo -e
success "Done."

