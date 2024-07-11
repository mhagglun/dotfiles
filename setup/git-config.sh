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
