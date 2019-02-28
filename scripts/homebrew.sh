#!/bin/sh

# Check for homebrew and install if needed
echo "Installing homebrew ..."

which -s brew
if [[ $? != 0 ]] ; then
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed ..."
fi

brew update

# GNU core utilities
brew install coreutils
brew install moreutils
brew install findutils


# Install more recent versions of some OS X tools.
brew tap homebrew/dupes
brew install grep --with-default-names

# highlightning
brew install source-highlight

# install zsh
brew install zsh
brew install tree
brew install getantibody/tap/antibody

# Git
brew install git

# Development
brew install python
brew install ruby

# Computational
brew install octave
brew install scipy
brew install numpy
brew install matplotlib

# Other
brew install wget
brew install curl
brew install micro
brew install neofetch
brew install cowsay
brew install dark-mode


brew cleanup
