# git
alias ga='git add'
alias gc='git commit -m'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gb='git checkout $(git branch -a | fzf | xargs echo) # interactive git branch'

gall() {git add . && git commit -m "$1" && git push}
