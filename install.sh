#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

echo Installing dotfiles.

for f in $DIR/patch/*.patch
do
    cat "$f"
    read -p "Apply $f? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
       git apply "$f"
    fi
done

mkdir -pv "~/.config/i3"
[[ -L "~/.config/i3/config" ]] && mv -v ~/.config/i3/config{,.bak}
ln -sfv $DIR/i3wm ~/.config/i3/config

[[ -L "~/.config/compton.conf" ]] && mv -v ~/.config/compton.conf{,.bak}
ln -sfv $DIR/compton.conf ~/.config/compton.conf

[[ -L "~/.bashrc" ]] && mv -v ~/.bashrc{,.bak}
ln -sfv $DIR/bashrc ~/.bashrc

[[ -L "~/.vimrc" ]] && mv -v ~/.vimrc{,.bak}
ln -sfv $DIR/vimrc ~/.vimrc

mkdir -pv ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

[[ -L "~/.gitconfig" ]] && mv -v ~/.gitconfig{,.bak}
ln -sfv $DIR/gitconfig ~/.gitconfig

mkdir -pv ~/.ssh
[[ -L "~/.ssh/config" ]] && mv -v ~/.ssh/config{,.bak}
ln -sfv $DIR/sshconfig ~/.ssh/config

[[ -L "~/.zshrc" ]] && mv -v ~/.zshrc ~/.zshrc.bak
ln -sfv $DIR/zshrc ~/.zshrc

read -p "Create ~/.local/bin?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [[ -e ~/.local/bin ]]; then
        TYPE=`stat ~/.local/bin --printf %F`
        if [[ $TYPE == "symbolic link" ]]; then
            rm -v ~/.local/bin
        else
            mv -v ~/.local/bin ~/.local/bin.bak
        fi
    fi
    ln -sfv $DIR/bin ~/.local/bin
    chmod -v +x ~/.local/bin/*
fi

echo Installed dotfiles.
