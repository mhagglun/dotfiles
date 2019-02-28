#!/bin/sh

symlink_dotfile() {
  ln -sfv $(grealpath $1) "$HOME/.$1"
}

symlink() {
  ln -sfv $(grealpath $1) "$HOME/$1"
}

echo "Creating symlinks ..."

pushd ./dots
symlink_dotfile .aliases
# symlink_dotfile .gitconfig
# symlink_dotfile .gitignore
# symlink_dotfile .gitmessage
symlink_dotfile .zshrc
symlink_dotfile .zsh_plugins.txt

# SSH
# mkdir "$HOME/.ssh"
# ln -sfv $(grealpath ssh-config) "$HOME/.ssh/config"
# popd

# ZSH/Terminal
ln -s ~/dotfiles/zsh/prompt/common.zsh-theme $HOME/.oh-my-zsh/themes
open "${HOME}/dotfiles/iterm/themes/Subliminal.itermcolors"

# Remove first so folders don't become nested if this runs more than once
rm "$HOME/iterm"

symlink iterm
