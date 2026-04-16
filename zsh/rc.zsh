export TERM=xterm-256color

source_if_exists() {
  if test -r "$1"; then
    source "$1"
  else
    printf "\r\033[2K  [\033[0;31mWARNING\033[0m] $1 does not exist or is not readable\n"
  fi
}

source_if_exists $HOME/.env.sh
source_if_exists $DOTFILES/zsh/aliases.zsh

## Exporting paths
export EDITOR=nvim
export PATH="$PATH:/usr/local/sbin:$DOTFILES/bin:$HOME/.local/bin:$DOTFILES/scripts/"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="/home/marcus/.bun/bin:$PATH"

# nvidia
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# gcp
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# ZSH History
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_all_dups

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5D' backward-word     # Ctrl+Left
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^H' backward-kill-word     # Ctrl+Backspace
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

# Completion styling
zstyle ":completion:*" list-colors "${(s.:.)ZLS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# Fixes slow pasting on larger snippets with fast-syntax-highlighting
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# compinit: only re-check security & rebuild dump if it's older than 24h
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# ZSH plugins
source_if_exists "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# OMZ snippets – load async after first prompt (turbo mode)
zinit ice wait lucid; zinit snippet OMZP::git
zinit ice wait lucid; zinit snippet OMZP::kubectl

# External plugins
zinit light zsh-users/zsh-autosuggestions  # keep sync: needed immediately for typing
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid; zinit light Aloxaf/fzf-tab
zinit ice wait lucid; zinit light djui/alias-tips

# ── Lazy NVM ──────────────────────────────────────────────────────────────────
# Only fully load the first time node/npm/nvm is called.
export NVM_DIR=~/.nvm
export PATH="$NVM_DIR/versions/node/$(command ls $NVM_DIR/versions/node 2>/dev/null | sort -V | tail -1)/bin:$PATH"

_load_nvm() {
  unset -f nvm node npm npx yarn pnpm corepack
  source_if_exists /usr/share/nvm/nvm.sh
  source_if_exists /usr/share/nvm/bash_completion
}
nvm()     { _load_nvm; nvm "$@"; }
node()    { _load_nvm; node "$@"; }
npm()     { _load_nvm; npm "$@"; }
npx()     { _load_nvm; npx "$@"; }
yarn()    { _load_nvm; yarn "$@"; }
pnpm()    { _load_nvm; pnpm "$@"; }
corepack(){ _load_nvm; corepack "$@"; }

# ── pyenv ────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ── Other tools ───────────────────────────────────────────────────────────────
if type "starship" > /dev/null; then
  eval "$(starship init zsh)"
fi

if type "fzf" > /dev/null; then
  source <(fzf --zsh)
fi

if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
fi
