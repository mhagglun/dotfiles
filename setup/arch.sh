#!/usr/bin/env bash

set -e

source "$(dirname "$0")/utils.sh"

# Function to install yay if not already installed
install_yay() {
    if ! command -v yay &> /dev/null; then
        info "Installing yay..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git "$HOME/.yay"
        cd "$HOME/.yay" && makepkg -si
        cd .. && rm -rf "$HOME/.yay" # Clean up after install
        success "Installed yay"
    else
        success "yay is already installed."
    fi
}

# Install yay
install_yay

# Install essential packages using yay
info "Installing base system packages and developer tools..."

yay -S --needed \
    git \
    zsh \
    base-devel \
    kitty \
    fzf \
    direnv \
    tldr \
    bat \
    btop \
    ripgrep \
    zoxide \
    neovim \
    zvm \
    npm \
    kubectl \
    kustomize \
    ttf-firacode-nerd \
    noto-fonts \

success "All packages installed and up-to-date."

# Post-installation message for btrfs rollbacks
user "NOTE: btrfs rollbacks require additional manual setup. Refer to documentation for configuring snapper and grub-btrfs."
