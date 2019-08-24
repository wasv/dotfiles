#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

echo Installing dependencies.

mkdir -pv ~/.vim/autoload/
wget -O ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

read -p "Create ~/.bin?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [[ -e ~/.bin ]]; then
        TYPE=`stat ~/.bin --printf %F`
        if [[ $TYPE == "symbolic link" ]]; then
            rm -v ~/.bin
        else
            mv -v ~/.bin ~/.bin.bak
        fi
    fi
    ln -sfv $DIR/bin ~/.bin
    chmod -v +x $DIR/bin/*
fi

read -p "Install oh-my-zsh? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    wget -O /tmp/oh-my-zsh-install.sh \
	 https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sh /tmp/oh-my-zsh-install.sh
    git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
    ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

[[ -L "~/.zshrc" ]] && mv -v ~/.zshrc ~/.zshrc.bak
ln -sfv $DIR/zshrc ~/.zshrc

echo Installed dotfiles.
