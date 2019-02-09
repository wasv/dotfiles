# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

#export DOCKER_HOST=tcp://gpgdrop.labs.makesthings.xyz:2376 DOCKER_TLS_VERIFY=1

RPROMPT="%D %T"

SPACESHIP_BATTERY=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_CHAR_SYMBOL="> "
SPACESHIP_GIT_STATUS_DELETED="X"
SPACESHIP_GIT_STATUS_AHEAD="^"
SPACESHIP_JOBS_SYMBOL="*"
SPACESHIP_GIT_STATUS_BEHIND=""

alias ]="xdg-open"
alias sl="echo Thats not ls!!"

[[ -e "$XDG_RUNTIME_DIR/keyring/ssh" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# Enables rust if available
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Fixes GPG Agent issues
if [ -n $SSH_CONNECTION ]; then
    export GPG_TTY=$(tty)
fi

[[ -f "$HOME/.myzshrc" ]] && source "$HOME/.myzshrc"

# Needed for emacs.
[ $TERM = "dumb" ] && unsetopt zle && PS1='%{$(pwd|grep --color=always /)%${#PWD}G%}$ '
