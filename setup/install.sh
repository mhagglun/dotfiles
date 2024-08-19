#!/usr/bin/env bash

set -e

source "$(dirname "$0")/utils.sh"

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

