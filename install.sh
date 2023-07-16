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

backup() {
    title "Backing Up"
    info "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    for file in $(get_linkables); do
        filename=".$(basename "$file" '.symlink')"
        target="$HOME/$filename"
        if [ -f "$target" ]; then
            info "backing up $filename"
            mv "$target" "$BACKUP_DIR"
        else
            warning "$filename does not exist at this location or is a symlink"
        fi
    done

    for filename in "$HOME/.vim" "$HOME/.vimrc"; do
        if [ ! -L "$filename" ]; then
            if [ -d "$filename" ]; then
                info "backing up $filename"
                mv -f "$filename" "$BACKUP_DIR"
            elif [[ -f "$filename" ]]; then
                info "backing up $filename"
                mv "$filename" "$BACKUP_DIR"
            else
                warning "$filename does not exist at this location or is a symlink"
                warning "removing $filename"
                rm -rf "$filename"
            fi
        else
            warning "$filename does not exist at this location or is a symlink"
            warning "removing $filename"
            rm -rf "$filename"
        fi
    done

    config_files=$(find "$DOTFILES/config" -maxdepth 1 -mindepth 1 2>/dev/null)
    for config in $config_files; do
        target="$HOME/.config/$(basename "$config")" 
        if [ ! -L "$target" ]; then
            if [ -d "$target" ]; then
                info "backing up $target"
                mv -f "$target" "$BACKUP_DIR"
            elif [[ -f "$target" ]]; then
                info "backing up $target"
                mv "$target" "$BACKUP_DIR"
            else
                warning "$target does not exist at this location or is a symlink"
                warning "removing $target"
                rm -rf "$target"
            fi
        else
            warning "$target does not exist at this location or is a symlink"
            warning "removing $target"
            rm -rf "$target"
        fi

    done
}

setup_symlinks() {
    title "Creating symlinks"

    for file in $(get_linkables) ; do
        target="$HOME/.$(basename "$file" '.symlink')"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping."
        else
            info "Creating symlink for $file"
            ln -f -s  "$file" "$target"
        fi
    done

    echo -e
    info "installing to ~/.config"
    if [ ! -d "$HOME/.config" ]; then
        info "Creating ~/.config"
        mkdir -p "$HOME/.config"
    fi

    config_files=$(find "$DOTFILES/config" -maxdepth 1 -mindepth 1 2>/dev/null)
    for config in $config_files; do
        target="$HOME/.config/$(basename "$config")"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping."
        else
            info "Creating symlink for $config"
            ln -f -s "$config" "$target"
        fi
    done
}

setup_nvim() {
    title "Backing Up"
    info "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    config="$DOTFILES/config/nvim"
    target="$HOME/.config/nvim"
    if [ ! -L "$target" ]; then
        if [ -d "$target" ]; then
            info "backing up $target"
            mv -f "$target" "$BACKUP_DIR"
        elif [[ -f "$target" ]]; then
            info "backing up $target"
            mv "$target" "$BACKUP_DIR"
        else
            warning "$target does not exist at this location or is a symlink"
            warning "removing $target"
            rm -rf "$target"
        fi
    else
        warning "$target does not exist at this location or is a symlink"
        warning "removing $target"
        rm -rf "$target"
    fi

    echo -e
    info "installing to ~/.config"
    ln -f -s "$config" "$target"
}

help() {
    echo -e $"\nUsage: ./$(basename "$0") <command>\n"
    echo -e "${COLOR_BLUE}Available commands:${COLOR_NONE}$1"
    echo -e $"all   : Setup all dottfile config; overide all existing configuration."
    echo -e $"nvim  : Setup nvim; overide all existing configuration."
}

all() {
    info "All backup config will store at $BACKUP_DIR"
    warning "Are you sure will overide all config for nvim and zsh? ([Y]es/[N]o)"
    read
    if [[ $REPLY == "y" || $REPLY == "Y" || $REPLY == "Yes" ]]; then
      backup
      setup_symlinks
    fi
}

case "$1" in
    all)
        all
        ;;
    nvim)
        setup_nvim
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

