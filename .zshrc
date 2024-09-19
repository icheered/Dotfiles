# If you come from bash you might have to change your $PATH.
export CUSTOM_ZSH_DIR=$HOME/Dotfiles/zsh

export EDITOR=vim
export NVM_COMPLETION=true
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000
export TIMEFMT="%E      system %S      user %U"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

REPORTTIME=1
ENABLE_CORRECTION="true"

# Source additional files (Aliases and small functions)
for file in $CUSTOM_ZSH_DIR/*.zsh; do
  [[ -f "$file" ]] && source "$file"
done

# Automatically install pluginmanager
[[ -r $CUSTOM_ZSH_DIR/plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $CUSTOM_ZSH_DIR/plugins/znap
source $CUSTOM_ZSH_DIR/plugins/znap/znap.zsh

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source joshskidmore/zsh-fzf-history-search

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"