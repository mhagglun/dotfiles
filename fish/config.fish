set -gx TERM xterm-256color
set fish_greeting # disable the default welcome message

# Source a file only if it exists and is readable, printing a warning otherwise.
function source_if_exists
    if test -r $argv[1]
        source $argv[1]
    else
        printf "\r\033[2K  [\033[0;31mWARNING\033[0m] $argv[1] does not exist or is not readable\n"
    end
end

source_if_exists $HOME/.env.dotfiles
source_if_exists $DOTFILES/fish/aliases.fish
source_if_exists $DOTFILES/aliases/git.fish
source_if_exists $DOTFILES/aliases/kubectl.fish

# ── Editor & PATH ─────────────────────────────────────────────────────────────
set -gx EDITOR nvim

fish_add_path /usr/local/sbin $DOTFILES/bin $HOME/.local/bin $DOTFILES/scripts
fish_add_path /opt/nvim-linux64/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.bun/bin

# NVIDIA / CUDA
fish_add_path /usr/local/cuda/bin
set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH

# GCP – fish has no path.fish.inc equivalent, so we add the bin directly.
# For shell completions install the gcloud component: gcloud components install beta
fish_add_path $HOME/google-cloud-sdk/bin

set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh

# ── History ───────────────────────────────────────────────────────────────────
# Fish manages history natively: it is persistent, deduplicated, and shared
# across sessions automatically. No extra config is required.

# ── Key bindings ──────────────────────────────────────────────────────────────
function fish_user_key_bindings
    bind \cp history-search-backward   # Ctrl+P
    bind \cn history-search-forward    # Ctrl+N
    bind \e\[1\;5D backward-word       # Ctrl+Left
    bind \e\[1\;5C forward-word        # Ctrl+Right
    bind \cH backward-kill-word        # Ctrl+Backspace
end

# ── pyenv ─────────────────────────────────────────────────────────────────────
set -gx PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT/bin
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
end

# ── Other tools ───────────────────────────────────────────────────────────────
if type -q starship
    starship init fish | source
end

# fzf key bindings and completions are provided by PatrickF1/fzf.fish.

if type -q zoxide
    zoxide init fish | source
end
