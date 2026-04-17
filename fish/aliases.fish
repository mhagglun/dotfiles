abbr --add v nvim
abbr --add vim nvim
abbr --add ls eza

abbr --add pbcopy wl-copy
abbr --add pbpaste wl-paste

# ── Git ───────────────────────────────────────────────────────────────────────

# List branches sorted by most recent commit
function git_branch_remote
    git for-each-ref --sort=-committerdate refs/heads/ \
        --format='%(color:red)%(committerdate:short) %(color:green)<%(authorname)> %(color:cyan)%(refname:short)'
end
abbr --add gbr git_branch_remote

# Soft-reset the last N commits: gu <n>
function gitundo
    git reset --soft HEAD~$argv[1]
end
abbr --add gu gitundo

# Show diff of changed files rendered via bat
function gitdiffbat
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
end
abbr --add gdb gitdiffbat

# ── Docker ────────────────────────────────────────────────────────────────────

# Kill and remove all containers, wipe api/dangling images, prune volumes
function dclear
    docker ps -a -q | xargs docker kill -f
    docker ps -a -q | xargs docker rm -f
    docker images | grep "api\|none" | awk '{print $3}' | xargs docker rmi -f
    docker volume prune -f
end
abbr --add docker-clear dclear
