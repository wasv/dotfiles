# -*- mode: sh -*-
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi
HISTSIZE=50000

# Normal Colors

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

NC="\e[m"               # Color Reset

export PS1="\d \t [\u@\h] \W \n\!\$ "

# Set pager program to less
alias less="less -R"
alias more="less"
export PAGER=less

# Set editor to vim
alias editor="vim"
export EDITOR=vim

# Ensure ls and grep use colors
alias ls="ls --color"
alias grep="grep --color"
alias "]"="xdg-open"

#Put bash in vi mode
#set -o vi
if [ -f ~/.mybashrc ]; then
    . ~/.mybashrc
fi

shopt -s extglob
