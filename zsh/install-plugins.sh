#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../setup/utils.sh"

if ! command_exists zinit; then
  info "Installing zinit..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  success "zinit installed"
else
  success "zinit already installed"
fi

# zinit plugins declared in rc.zsh are downloaded automatically on first shell
# start (turbo/wait mode), so no pre-download step is needed here.
info "ZSH plugins will be fetched by zinit on first shell start."
