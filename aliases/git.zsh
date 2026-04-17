# Git aliases – mirrors the OMZ git plugin.
# Excluded: bisect (gbs*), SVN (gsd/gsr), GUI tools (gg*/gk*), worktree (gwt*).
# Note: gbr is intentionally omitted; it is defined as git_branch_remote in aliases.zsh.

# ── Helpers ───────────────────────────────────────────────────────────────────

git_current_branch() {
  git branch --show-current 2>/dev/null
}

git_main_branch() {
  local ref
  ref=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null) \
    && echo "${ref#refs/remotes/origin/}" && return
  for ref in main master; do
    git show-ref -q --verify "refs/heads/$ref" 2>/dev/null && echo "$ref" && return
  done
  echo main
}

git_develop_branch() {
  for ref in develop dev; do
    git show-ref -q --verify "refs/heads/$ref" 2>/dev/null && echo "$ref" && return
  done
  echo develop
}

# ── Core ──────────────────────────────────────────────────────────────────────
alias g='git'

# ── Add ───────────────────────────────────────────────────────────────────────
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'

# ── Branch ────────────────────────────────────────────────────────────────────
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbl='git blame -w'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'

# ── Checkout / Switch ─────────────────────────────────────────────────────────
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'

# ── Clone ─────────────────────────────────────────────────────────────────────
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
alias gclean='git clean --interactive -d'

# ── Commit ────────────────────────────────────────────────────────────────────
alias gc='git commit --verbose'
alias gce='git commit --verbose --amend'
alias gca='git commit --verbose --all'
alias gcae='git commit --verbose --all --amend'
alias gcam='git commit --all --message'
alias gcane='git commit --verbose --all --no-edit --amend'
alias 'gcann!'='git commit --verbose --all --date=now --no-edit --amend'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gcmsg='git commit --message'
alias gcn='git commit --verbose --no-edit'
alias gcne='git commit --verbose --no-edit --amend'
alias gcs='git commit --gpg-sign'
alias gcsm='git commit --signoff --message'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gcount='git shortlog --summary --numbered'

# ── Cherry-pick ───────────────────────────────────────────────────────────────
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# ── Diff ──────────────────────────────────────────────────────────────────────
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

# ── Fetch ─────────────────────────────────────────────────────────────────────
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'
alias gfg='git ls-files | grep'

# ── Log ───────────────────────────────────────────────────────────────────────
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'

# ── Merge ─────────────────────────────────────────────────────────────────────
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmom='git merge origin/$(git_main_branch)'
alias gms='git merge --squash'
alias gmum='git merge upstream/$(git_main_branch)'

# ── Pull ──────────────────────────────────────────────────────────────────────
alias gl='git pull'
alias ggpull='git pull origin "$(git_current_branch)"'
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'

# ── Push ──────────────────────────────────────────────────────────────────────
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpff='git push --force'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpu='git push upstream'

# ── Rebase ────────────────────────────────────────────────────────────────────
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'
alias grbum='git rebase upstream/$(git_main_branch)'

# ── Remote ────────────────────────────────────────────────────────────────────
alias gr='git remote'
alias gra='git remote add'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grv='git remote --verbose'

# ── Reset ─────────────────────────────────────────────────────────────────────
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias groh='git reset origin/$(git_current_branch) --hard'
alias gru='git reset --'

# ── Restore ───────────────────────────────────────────────────────────────────
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

# ── Revert ────────────────────────────────────────────────────────────────────
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'

# ── Rm ────────────────────────────────────────────────────────────────────────
alias grm='git rm'
alias grmc='git rm --cached'

# ── Show ──────────────────────────────────────────────────────────────────────
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

# ── Stash ─────────────────────────────────────────────────────────────────────
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gstu='git stash push --include-untracked'

# ── Status ────────────────────────────────────────────────────────────────────
alias gst='git status'
alias gsb='git status --short --branch'
alias gss='git status --short'

# ── Submodule ─────────────────────────────────────────────────────────────────
alias gsi='git submodule init'
alias gsu='git submodule update'

# ── Tag ───────────────────────────────────────────────────────────────────────
alias gta='git tag --annotate'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
gtl() { git tag --sort=-v:refname -n --list "${1}*"; }

# ── Misc ──────────────────────────────────────────────────────────────────────
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias grf='git reflog'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\-\-wip\-\-" && git reset HEAD~1'
alias gwch='git log --patch --abbrev-commit --pretty=medium --raw'
alias gwipe='git reset --hard && git clean --force -df'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
