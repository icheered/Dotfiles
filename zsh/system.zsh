# navigation
alias ..='cd ..'            # parent dir
alias ...='cd ../..'        # two dirs up
alias ....='cd ../../..'    # three dirs up alias .2='cd ../..'         # two dirs up
alias .3='cd ../../..'      # three dirs up
alias .4='cd ../../../..'   # four dirs up
alias .5='cd ../../../../..' # five dirs up

# file & dirs
alias cp='cp -iv'           # cp: interactive; verbose
alias mv='mv -iv'           # mv: interactive; verbose
alias rm='echo USE RIP INSTEAD'           # rm: interactive; verbose
alias mkdir='mkdir -pv'     # mkdir: parents; verbose

# Better defaults
alias ls='ls --color=auto -lAh' 
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

# Debian commands
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot"
alias sleep="sudo systemctl suspend"

# Bindkeys for ZSH
bindkey '^H' backward-kill-word
