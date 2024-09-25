#!/usr/bin/env bash

set -e

info "Updating package lists..."
sudo apt-get update
success "Package lists updated"

# List of Python build dependencies
# See https://github.com/pyenv/pyenv/wiki#suggested-build-environment
PYTHON_BUILD_DEPENDENCIES=(
  build-essential
  libssl-dev
  zlib1g-dev
  libbz2-dev
  libreadline-dev
  libsqlite3-dev
  curl
  git
  libncursesw5-dev
  xz-utils
  tk-dev
  libxml2-dev
  libxmlsec1-dev
  libffi-dev
  liblzma-dev
)
# Check and install Python build dependencies
info "Checking Python build dependencies..."
missing_packages=()
for pkg in "${PYTHON_BUILD_DEPENDENCIES[@]}"; do
  if ! package_exists "$pkg"; then
    missing_packages+=("$pkg")
  fi
done

if [ ${#missing_packages[@]} -ne 0 ]; then
  info "Installing missing packages: ${missing_packages[*]}..."
  sudo apt-get install -y "${missing_packages[@]}"
else
  success "All Python build dependencies are already installed."
fi


APT_LIBS=(
    zsh
    tmux
    zoxide
    fzf
    jq
    bat
    ripgrep
    xclip
)

info "Checking install for apt..."
for pkg in "${APT_LIBS[@]}"; do
  if ! package_exists "$pkg"; then
    info "Installing $pkg..."
    sudo apt-get install -y "$pkg"
    success "Installed $pkg"
  else
    success "$pkg is already installed"
  fi
done
success "All apt packages are installed"
