#!/usr/bin/env bash

set -e

source "$(dirname "$0")/../setup/utils.sh"

if ! fish -c "type -q fisher" 2>/dev/null; then
  info "Installing fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  success "fisher installed"
else
  success "fisher already installed"
fi

info "Installing fish plugins..."
fish -c "fisher install \
  PatrickF1/fzf.fish \
  gazorby/fish-abbreviation-tips \
  jorgebucaran/nvm.fish"
success "Fish plugins installed"
