alias vim=nvim
alias cat=/usr/bin/batcat

## Clipboard copy / paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

git_branch_remote() {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: green)<%(authorname)> %(color: cyan)%(refname:short)'
}

alias gbr=git_branch_remote

# Git stuff
gitundo () {
  git reset --soft HEAD~$1
}

alias gu=gitundo

gitdiffbat() {
    git diff --name-only --relative --diff-filter=d | xargs batcat --diff
}

alias gdb=gitdiffbat


# Docker
dclear () {
    docker ps -a -q | xargs docker kill -f
    docker ps -a -q | xargs docker rm -f
    docker images | grep "api\|none" | awk '{print $3}' | xargs docker rmi -f
    docker volume prune -f
}

alias docker-clear=dclear
