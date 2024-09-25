#!/usr/bin/env bash

set -e

source "$(dirname "$0")/utils.sh"

# Detect the OS and run the corresponding script to install
# packages with respective package manager
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "arch" || "$ID_LIKE" == "arch" ]]; then
        info "Detected Arch-based OS. Running arch.sh..."
        bash "$(dirname "$0")/arch.sh"
    elif [[ "$ID" == "ubuntu" || "$ID_LIKE" == "debian" ]]; then
        info "Detected Ubuntu-based OS. Running apt.sh..."
        bash "$(dirname "$0")/apt.sh"
    else
        error "Unsupported OS: $ID"
        exit 1
    fi
else
    error "Cannot detect OS. /etc/os-release not found."
    exit 1
fi

# ----------------------------------------------------------

if ! directory_exists "$HOME/.oh-my-zsh"; then
    info "oh-my-zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    info "installing zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions"
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
    git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"
    git clone https://github.com/djui/alias-tips.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/alias-tips"

    success "oh-my-zsh installed"
else
    success "oh-my-zsh is already installed."
fi

# ----------------------------------------------------------

if ! command_exists starship; then
  info "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh
  success "starship installed"
else
  success "starship is already installed"
fi

# ----------------------------------------------------------

if ! command_exists pyenv; then
    info "Installing pyenv..."
    curl https://pyenv.run | bash
    success "pyenv installed"
else
    success "pyenv already installed"
fi

# ----------------------------------------------------------

if ! command_exists poetry; then
    info "Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    success "poetry installed"
else
    success "poetry is already installed"
fi


# Change default shell to zsh if it isn't already
if [ "$SHELL" != "$(which zsh)" ]; then
  info "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
  success "Default shell changed to zsh. Please log out and log back in to use zsh as the default shell."
else
  success "zsh is already the default shell."
fi

success "All tasks completed successfully!"

