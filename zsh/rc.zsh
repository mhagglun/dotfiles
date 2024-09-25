source_if_exists () {
    if test -r "$1"; then
        source "$1"
    else
        printf "\r\033[2K  [\033[0;31mWARNING\033[0m] $1 does not exist or is not readable\n"
    fi
}

source_if_exists $HOME/.env.sh

# Hotreload aliases
precmd() {
    source $DOTFILES/zsh/aliases.zsh
}

## Exporting paths
export EDITOR=nvim
export ZSH=$HOME/.oh-my-zsh
export PATH="$PATH:/usr/local/sbin:$DOTFILES/bin:$HOME/.local/bin:$DOTFILES/scripts/"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/usr/local/go/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.local/share/pypoetry/venv/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvidia
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# ZSH History
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEFILE=$HISTFILE
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

# Completion styling
zstyle ":completion:*" list-colors "${(s.:.)ZLS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# Fixes slow pasting on larger snippets with fast-syntax-highlighting
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# OMZ plugins
plugins=(git kubectl alias-tips fzf-tab zsh-autosuggestions fast-syntax-highlighting)
fpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

if type "fzf" > /dev/null; then
    source <(fzf --zsh)
fi

if type "direnv" > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if type "pyenv" > /dev/null; then
    eval "$(pyenv init -)"
fi

if type "zoxide" > /dev/null; then
    eval "$(zoxide init zsh)"
fi

if type "starship" > /dev/null; then
    eval "$(starship init zsh)"
fi
