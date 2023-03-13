#!/usr/bin/env bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

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
    BACKUP_DIR=$HOME/dotfiles-backup

    title "Backing Up"
    echo "Creating backup directory at $BACKUP_DIR"
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

case "$1" in
  backup)
    backup
    ;;
  symlink)
    setup_symlinks
    ;;
  help)
    echo -e $"\nUsage: $(basename "$0") {backup|symlink}\n"
    exit 1
    ;;
  *)
    echo -e $"\nUsage: $(basename "$0") {backup|symlink}\n"
    exit 1
    ;;
esac

echo -e
success "Done."

