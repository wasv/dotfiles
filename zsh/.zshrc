#!/bin/zsh
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _prefix
zstyle ':completion:*' match-original both
zstyle :compinstall filename '$HOME/.zshrc'

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

# Fix home,end,pgup,pgdn
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

PROMPT="%F{magenta}%n%f at %F{yellow}%m%f in %F{cyan}%3~%f"$'\n'"%h %# "
RPROMPT="\$?=%? - %D %*"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function "]" {
  xdg-open $@ & disown
}
alias sl="echo Thats not ls!!"
alias dc="rlwrap dc"

# Enables rust if available
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Source external zshrc files
if test -d $HOME/.zshrc.d/; then
	for zshrcd in $HOME/.zshrc.d/*.zsh; do
		test -r "$zshrcd" && . "$zshrcd"
	done
	unset zshrcd
fi
