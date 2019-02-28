# oh-my-zsh
export ZSH=/Users/marcus/.oh-my-zsh

# Theme
ZSH_THEME="common"

# Aliases
source $HOME/.aliases
# Antibody
source ~/.zsh_plugins.sh

# Disable auto-setting terminal title.
   DISABLE_AUTO_TITLE="true"
  function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"

  function title(){
  TITLE="\[\e]2;$*\a\]"
  echo -e ${TITLE}
}
}

# Ruby
eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source $ZSH/oh-my-zsh.sh
