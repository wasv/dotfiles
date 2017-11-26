# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/wasv/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
RPROMPT='%* [%F{yellow}%?%f]'

alias ls="ls --color"
alias grep="grep --color"
