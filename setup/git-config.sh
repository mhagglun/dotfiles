#!/usr/bin/env bash
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.editor nvim
git config --global diff.algorithm histogram
git config --global fetch.prune true
git config --global fetch.prunetags true
git config --global branch.sort committerdate
git config --global tag.sort taggerdate
git config --global log.date iso

# Kitty diff tool
git config --global diff.tool kitty
git config --global diff.guitool kitty.gui
git config --global difftool.prompt false
git config --global difftool.trustExitCode true
git config --global difftool.kitty.cmd 'kitty +kitten diff "$LOCAL" "$REMOTE"'
git config --global difftool.kitty.gui.cmd 'kitty +kitten diff "$LOCAL" "$REMOTE"'
