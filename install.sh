#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

echo Installing dependencies.

mkdir -pv ~/.vim/autoload/
wget -O ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo Installing dotfiles.
read -p "Install emacs config? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    [[ -L "~/.emacs.d" ]] && mv -v ~/.emacs.d ~/.emacs.d.bak
    git clone git@github.com:wastevensv/emacs.d ~/.emacs.d
fi

for f in $DIR/patch/*.patch
do
    cat "$f"
    read -p "Apply $f? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
       git apply "$f"
    fi
done

[[ -L "~/.bashrc" ]] && mv -v ~/.bashrc ~/.bashrc.bak
ln -sfv $DIR/bashrc ~/.bashrc

[[ -L "~/.zshrc" ]] && mv -v ~/.zshrc ~/.zshrc.bak
ln -sfv $DIR/zshrc ~/.zshrc

[[ -L "~/.vimrc" ]] && mv -v ~/.vimrc ~/.vimrc.bak
ln -sfv $DIR/vimrc ~/.vimrc

mkdir -pv ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

mkdir -pv ~/.config/fish
[[ -L "~/.config/fish/config.fish" ]] && mv -v ~/.config/fish/config.fish{,.bak}
ln -sfv $DIR/config.fish ~/.config/fish/config.fish

[[ -L "~/.gitconfig" ]] && mv -v ~/.gitconfig{,.bak}
ln -sfv $DIR/gitconfig ~/.gitconfig

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
    wget -O /tmp/zsh-spaceship-install.sh https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.zsh
    cat /tmp/zsh-spaceship-install.sh | zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo Installed dotfiles.
