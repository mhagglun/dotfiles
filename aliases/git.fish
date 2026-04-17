# Git abbreviations – mirrors the OMZ git plugin.
# Excluded: bisect (gbs*), SVN (gsd/gsr), GUI tools (gg*/gk*), worktree (gwt*).
# Excluded: aliases using '!' in their names (invalid in fish function names).
# Note: gbr is intentionally omitted; it is defined as git_branch_remote in aliases.fish.
#
# Simple expansions use abbr --add so they expand inline at the prompt.
# Anything requiring runtime branch detection or multi-step logic is a function.

# ── Helpers ───────────────────────────────────────────────────────────────────

function git_current_branch
    git branch --show-current 2>/dev/null
end

function git_main_branch
    set -l ref (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null)
    if test -n "$ref"
        echo $ref | sed 's@^refs/remotes/origin/@@'
        return
    end
    for ref in main master
        git show-ref -q --verify "refs/heads/$ref" 2>/dev/null && echo $ref && return
    end
    echo main
end

function git_develop_branch
    for ref in develop dev
        git show-ref -q --verify "refs/heads/$ref" 2>/dev/null && echo $ref && return
    end
    echo develop
end

# ── Core ──────────────────────────────────────────────────────────────────────
abbr --add g git

# ── Add ───────────────────────────────────────────────────────────────────────
abbr --add ga 'git add'
abbr --add gaa 'git add --all'
abbr --add gapa 'git add --patch'
abbr --add gau 'git add --update'
abbr --add gav 'git add --verbose'

# ── Branch ────────────────────────────────────────────────────────────────────
abbr --add gb 'git branch'
abbr --add gba 'git branch --all'
abbr --add gbd 'git branch --delete'
abbr --add gbD 'git branch --delete --force'
abbr --add gbg 'LANG=C git branch -vv | grep ": gone]"'
function gbgd
    LANG=C git branch --no-color -vv | grep ': gone]' | cut -c 3- | awk '{print $1}' | xargs git branch -d
end
function gbgD
    LANG=C git branch --no-color -vv | grep ': gone]' | cut -c 3- | awk '{print $1}' | xargs git branch -D
end
abbr --add gbl 'git blame -w'
abbr --add gbm 'git branch --move'
abbr --add gbnm 'git branch --no-merged'

# ── Checkout / Switch ─────────────────────────────────────────────────────────
abbr --add gcb 'git checkout -b'
abbr --add gcB 'git checkout -B'
function gcd
    git checkout (git_develop_branch)
end
function gcm
    git checkout (git_main_branch)
end
abbr --add gco 'git checkout'
abbr --add gcor 'git checkout --recurse-submodules'
abbr --add gsw 'git switch'
abbr --add gswc 'git switch --create'
function gswd
    git switch (git_develop_branch)
end
function gswm
    git switch (git_main_branch)
end

# ── Clone ─────────────────────────────────────────────────────────────────────
abbr --add gcl 'git clone --recurse-submodules'
abbr --add gclf 'git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
abbr --add gclean 'git clean --interactive -d'

# ── Commit ────────────────────────────────────────────────────────────────────
abbr --add gc 'git commit --verbose'
abbr --add gca 'git commit --verbose --all'
abbr --add gcam 'git commit --all --message'
abbr --add gcas 'git commit --all --signoff'
abbr --add gcasm 'git commit --all --signoff --message'
abbr --add gcf 'git config --list'
abbr --add gcfu 'git commit --fixup'
abbr --add gcmsg 'git commit --message'
abbr --add gcn 'git commit --verbose --no-edit'
abbr --add gce  'git commit --verbose --amend'
abbr --add gcae 'git commit --verbose --all --amend'
abbr --add gcane 'git commit --verbose --all --no-edit --amend'
abbr --add gcne  'git commit --verbose --no-edit --amend'
abbr --add gcs 'git commit --gpg-sign'
abbr --add gcsm 'git commit --signoff --message'
abbr --add gcss 'git commit --gpg-sign --signoff'
abbr --add gcssm 'git commit --gpg-sign --signoff --message'
abbr --add gcount 'git shortlog --summary --numbered'

# ── Cherry-pick ───────────────────────────────────────────────────────────────
abbr --add gcp 'git cherry-pick'
abbr --add gcpa 'git cherry-pick --abort'
abbr --add gcpc 'git cherry-pick --continue'

# ── Diff ──────────────────────────────────────────────────────────────────────
abbr --add gd 'git diff'
abbr --add gdca 'git diff --cached'
function gdct
    git describe --tags (git rev-list --tags --max-count=1)
end
abbr --add gdcw 'git diff --cached --word-diff'
abbr --add gds 'git diff --staged'
abbr --add gdt 'git diff-tree --no-commit-id --name-only -r'
abbr --add gdup 'git diff @{upstream}'
abbr --add gdw 'git diff --word-diff'

# ── Fetch ─────────────────────────────────────────────────────────────────────
abbr --add gf 'git fetch'
abbr --add gfa 'git fetch --all --prune'
abbr --add gfo 'git fetch origin'
abbr --add gfg 'git ls-files | grep'

# ── Log ───────────────────────────────────────────────────────────────────────
abbr --add glo 'git log --oneline --decorate'
abbr --add glog 'git log --oneline --decorate --graph'
abbr --add gloga 'git log --oneline --decorate --graph --all'
abbr --add glg 'git log --stat'
abbr --add glgp 'git log --stat --patch'
abbr --add glgg 'git log --graph'
abbr --add glgga 'git log --graph --decorate --all'
abbr --add glod 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
abbr --add glods 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
abbr --add glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
abbr --add glola 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
abbr --add glols 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'

# ── Merge ─────────────────────────────────────────────────────────────────────
abbr --add gm 'git merge'
abbr --add gma 'git merge --abort'
abbr --add gmc 'git merge --continue'
abbr --add gmff 'git merge --ff-only'
function gmom
    git merge origin/(git_main_branch)
end
abbr --add gms 'git merge --squash'
function gmum
    git merge upstream/(git_main_branch)
end

# ── Pull ──────────────────────────────────────────────────────────────────────
abbr --add gl 'git pull'
function ggpull
    git pull origin (git_current_branch)
end
function gluc
    git pull upstream (git_current_branch)
end
function glum
    git pull upstream (git_main_branch)
end
abbr --add gpr 'git pull --rebase'
abbr --add gpra 'git pull --rebase --autostash'
function gprom
    git pull --rebase origin (git_main_branch)
end
function gpromi
    git pull --rebase=interactive origin (git_main_branch)
end
function gprum
    git pull --rebase upstream (git_main_branch)
end
function gprumi
    git pull --rebase=interactive upstream (git_main_branch)
end

# ── Push ──────────────────────────────────────────────────────────────────────
abbr --add gp 'git push'
abbr --add gpd 'git push --dry-run'
abbr --add gpf  'git push --force-with-lease'
abbr --add gpff 'git push --force'
function ggpush
    git push origin (git_current_branch)
end
function ggsup
    git branch --set-upstream-to=origin/(git_current_branch)
end
function gpoat
    git push origin --all && git push origin --tags
end
abbr --add gpod 'git push origin --delete'
function gpsup
    git push --set-upstream origin (git_current_branch)
end
abbr --add gpu 'git push upstream'

# ── Rebase ────────────────────────────────────────────────────────────────────
abbr --add grb 'git rebase'
abbr --add grba 'git rebase --abort'
abbr --add grbc 'git rebase --continue'
function grbd
    git rebase (git_develop_branch)
end
abbr --add grbi 'git rebase --interactive'
function grbm
    git rebase (git_main_branch)
end
abbr --add grbo 'git rebase --onto'
function grbom
    git rebase origin/(git_main_branch)
end
abbr --add grbs 'git rebase --skip'
function grbum
    git rebase upstream/(git_main_branch)
end

# ── Remote ────────────────────────────────────────────────────────────────────
abbr --add gr 'git remote'
abbr --add gra 'git remote add'
abbr --add grmv 'git remote rename'
abbr --add grrm 'git remote remove'
abbr --add grset 'git remote set-url'
abbr --add grup 'git remote update'
abbr --add grv 'git remote --verbose'

# ── Reset ─────────────────────────────────────────────────────────────────────
abbr --add grh 'git reset'
abbr --add grhh 'git reset --hard'
abbr --add grhk 'git reset --keep'
abbr --add grhs 'git reset --soft'
function groh
    git reset origin/(git_current_branch) --hard
end
abbr --add gru 'git reset --'

# ── Restore ───────────────────────────────────────────────────────────────────
abbr --add grs 'git restore'
abbr --add grss 'git restore --source'
abbr --add grst 'git restore --staged'

# ── Revert ────────────────────────────────────────────────────────────────────
abbr --add grev 'git revert'
abbr --add greva 'git revert --abort'
abbr --add grevc 'git revert --continue'

# ── Rm ────────────────────────────────────────────────────────────────────────
abbr --add grm 'git rm'
abbr --add grmc 'git rm --cached'

# ── Show ──────────────────────────────────────────────────────────────────────
abbr --add gsh 'git show'
abbr --add gsps 'git show --pretty=short --show-signature'

# ── Stash ─────────────────────────────────────────────────────────────────────
abbr --add gsta 'git stash push'
abbr --add gstaa 'git stash apply'
abbr --add gstall 'git stash --all'
abbr --add gstc 'git stash clear'
abbr --add gstd 'git stash drop'
abbr --add gstl 'git stash list'
abbr --add gstp 'git stash pop'
abbr --add gsts 'git stash show --patch'
abbr --add gstu 'git stash push --include-untracked'

# ── Status ────────────────────────────────────────────────────────────────────
abbr --add gst 'git status'
abbr --add gsb 'git status --short --branch'
abbr --add gss 'git status --short'

# ── Submodule ─────────────────────────────────────────────────────────────────
abbr --add gsi 'git submodule init'
abbr --add gsu 'git submodule update'

# ── Tag ───────────────────────────────────────────────────────────────────────
abbr --add gta 'git tag --annotate'
abbr --add gts 'git tag --sign'
abbr --add gtv 'git tag | sort -V'
function gtl
    git tag --sort=-v:refname -n --list "$argv[1]*"
end

# ── Misc ──────────────────────────────────────────────────────────────────────
abbr --add ghh 'git help'
abbr --add gignore 'git update-index --assume-unchanged'
abbr --add gignored 'git ls-files -v | grep "^[[:lower:]]"'
abbr --add grf 'git reflog'
function grt
    cd (git rev-parse --show-toplevel 2>/dev/null; or echo .)
end
abbr --add gunignore 'git update-index --no-assume-unchanged'
function gunwip
    git rev-list --max-count=1 --format="%s" HEAD | grep -q -- --wip-- && git reset HEAD~1
end
abbr --add gwch 'git log --patch --abbrev-commit --pretty=medium --raw'
abbr --add gwipe 'git reset --hard && git clean --force -df'
function gwip
    git add -A
    git rm (git ls-files --deleted) 2>/dev/null
    git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"
end
