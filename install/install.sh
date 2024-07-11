#!/usr/bin/env bash

set -e

source "$(dirname "$0")/utils.sh"
info "Starting installation of packages..."

# Check and install zsh
if ! command -v zsh &> /dev/null
then
  info "Installing zsh..."
  sudo apt-get update
  sudo apt-get install -y zsh
  success "zsh installed"
else
  success "zsh is already installed"
fi

# Check and install starship
if ! command -v starship &> /dev/null
then
  info "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh
  success "starship installed"
else
  success "starship is already installed"
fi


info "Installation of packages completed."

# Change default shell to zsh if it isn't already
if [ "$SHELL" != "$(which zsh)" ]; then
  info "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
  success "Default shell changed to zsh. Please log out and log back in to use zsh as the default shell."
else
  success "zsh is already the default shell."
fi

success "All tasks completed successfully!"

