# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="icheered"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Load zsh-autosuggestions
if [ -f /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load zsh-syntax-highlighting (must be last)
if [ -f /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run alias.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# poetry and python
alias python="python3"
export PATH="/home/tjbakker/.local/bin:$PATH"
alias pos="poetry shell"
alias pm="python main.py"
alias prp="poetry run python"
alias ls='ls --color=auto -lAh' 
alias "poetry init -y"="poetry init -n"

# git
alias ga='git add'
alias gc='git commit -m'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
gall() {git add . && git commit -m "$1" && git push}
alias gb='git checkout $(git branch -a | fzf | xargs echo) # interactive git branch'

# yarn
alias yd='yarn dev'
alias yb='yarn build'
alias ys='yarn start'

alias initsvelte='npm create @svelte-add/kit@latest . -- --with typescript+tailwindcss+eslint+prettier --tailwindcss-daisyui --tailwindcss-typography'

# docker
alias dcm='docker-compose'
dlog() { docker logs --follow --tail 100 "$1"; }
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
alias dockrun='docker run -e HSA_OVERRIDE_GFX_VERSION=10.3.0 -it --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/pwd'

# network
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias caddyreload='docker-compose exec caddy caddy reload -config /etc/caddy/Caddyfile'

# Power
alias power='echo Power usage: $(( $(cat /sys/class/power_supply/BAT0/power_now) / 1000 )) mW'
alias hours='python3 ~/Scripts/hours.py'
alias herokuenv='python3 ~/Scripts/parseHerokuEnv.py'

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
alias rm='rm -iv'           # rm: interactive; verbose
alias mkdir='mkdir -pv'     # mkdir: parents; verbose

# Debian commands
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot"
alias sleep="sudo systemctl suspend"

# OpenVPN shortcuts
function vpnnew () {
 docker-compose run --rm openvpn easyrsa build-client-full $1 nopass && docker-compose run --rm openvpn ovpn_getclient $1 > $1.ovpn 
}
function vpncreate () {
 docker-compose run --rm openvpn easyrsa build-client-full $1 nopass
}
function vpnexport () {
 docker-compose run --rm openvpn ovpn_getclient $1 > $1.ovpn 
}
function vpndelete () {
 docker-compose run --rm openvpn ovpn_revokeclient $1 remove
}

# Bindkeys for ZSH
bindkey '^H' backward-kill-word

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/opt/nvim-linux64/bin"
