#!/bin/zsh
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _prefix
zstyle ':completion:*' match-original both
zstyle :compinstall filename '/home/billie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt appendhistory extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
bindkey "$key[Up]" history-beginning-search-backward # Up
bindkey "$key[Down]" history-beginning-search-forward # Down

PATH="$HOME/.local/bin:$PATH"

PROMPT="%F{magenta}%n%f at %F{yellow}%m%f in %F{cyan}%3~%f"$'\n'"%h %# "
RPROMPT="=%? - %D %*"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ]="xdg-open"
alias sl="echo Thats not ls!!"
alias dc="rlwrap dc"

[[ -e "$XDG_RUNTIME_DIR/keyring/ssh" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# Enables rust if available
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Fixes GPG Agent issues
if [ -n $SSH_CONNECTION ]; then
    export GPG_TTY=$(tty)
fi

[[ -f "$HOME/.myzshrc" ]] && source "$HOME/.myzshrc"

# Needed for emacs.
[ $TERM = "dumb" ] && unsetopt zle && PS1="%{$(pwd|grep --color=always /)%${#PWD}G%} %# " && return

[ -z $TMUX ] && which tmux && exec tmux -f $HOME/.tmux.conf
