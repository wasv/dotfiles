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
bindkey "\eOA" history-beginning-search-backward # Up
bindkey "\eOB" history-beginning-search-forward # Down
bindkey "\e[A" history-beginning-search-backward # Up
bindkey "\e[B" history-beginning-search-forward # Down

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

export MANPATH="$HOME/.local/share/man:"

PROMPT="%F{magenta}%n%f at %F{yellow}%m%f in %F{cyan}%3~%f"$'\n'"%h %# "
RPROMPT="\$?=%? - %D %*"

export FZF_DEFAULT_OPTS="--preview='file {}' --preview-window down:1"

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

function "]" {
  xdg-open $@ & disown
}
alias sl="echo Thats not ls!!"
alias dc="rlwrap dc"

alias fcd='DEST=`find -type d | fzf` ; cd $DEST'


[[ -e "$XDG_RUNTIME_DIR/keyring/ssh" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# Enables rust if available
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Fixes GPG Agent issues
if [ -n $SSH_CONNECTION ]; then
    export GPG_TTY=$(tty)
fi

[[ -f "$HOME/.myzshrc" ]] && source "$HOME/.myzshrc"

# [ -z $TMUX ] && [ -z $SSH_CONNECTION ] && which tmux 2>/dev/null && exec tmux -f $HOME/.tmux.conf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Needed for emacs.
[ $TERM = "dumb" ] && unsetopt zle && PS1="%{$(pwd|grep --color=always /)%${#PWD}G%} %# " && return
