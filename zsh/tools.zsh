# Network
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias caddyreload='docker-compose exec caddy caddy reload -config /etc/caddy/Caddyfile'

# Power
alias power='echo Power usage: $(( $(cat /sys/class/power_supply/BAT0/power_now) / 1000 )) mW'

# Docker
alias dcm='docker-compose'
dlog() { docker logs --follow --tail 100 "$1"; }
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
alias dockrun='docker run -e HSA_OVERRIDE_GFX_VERSION=10.3.0 -it --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/pwd'

# OpenVPN
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

# Sveltekit
alias initsvelte='npm create @svelte-add/kit@latest . -- --with typescript+tailwindcss+eslint+prettier --tailwindcss-daisyui --tailwindcss-typography'