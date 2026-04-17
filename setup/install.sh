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

# Prompt for shell choice
chosen_shell=""
while [[ "$chosen_shell" != "fish" && "$chosen_shell" != "zsh" ]]; do
  user "Which shell would you like to use? [fish/zsh]: "
  read -r chosen_shell </dev/tty
done

# Install plugins for the chosen shell
if [[ "$chosen_shell" == "fish" ]]; then
  if ! command_exists fish; then
    fail "fish is not installed. Please install it first."
  fi
  bash "$(dirname "$0")/../fish/install-plugins.sh"
else
  if ! command_exists zsh; then
    fail "zsh is not installed. Please install it first."
  fi
  bash "$(dirname "$0")/../zsh/install-plugins.sh"
fi

# Change default shell if needed
chosen_shell_path="$(which "$chosen_shell")"
if [ "$SHELL" != "$chosen_shell_path" ]; then
  info "Changing default shell to $chosen_shell..."
  chsh -s "$chosen_shell_path"
  success "Default shell changed to $chosen_shell. Please log out and log back in for the change to take effect."
else
  success "$chosen_shell is already the default shell."
fi

success "All tasks completed successfully!"
