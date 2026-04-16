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
    info "Detected Ubuntu-based OS. Running ubuntu.sh..."
    bash "$(dirname "$0")/ubuntu.sh"
  else
    error "Unsupported OS: $ID"
    exit 1
  fi
else
  error "Cannot detect OS. /etc/os-release not found."
  exit 1
fi

# ----------------------------------------------------------

if ! command_exists zinit; then
  info "Installing zinit..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  success "zinit installed"
else
  success "zinit already installed"
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
