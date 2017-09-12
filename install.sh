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

[[ -L "~/.vimrc" ]] && mv -v ~/.vimrc ~/.vimrc.bak
ln -sfv $DIR/vimrc ~/.vimrc

mkdir -v ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

[[ -L "~/.gitconfig" ]] && mv -v ~/.gitconfig ~/.gitconfig.bak
ln -sfv $DIR/gitconfig ~/.gitconfig

[[ -L "~/.ssh/config" ]] && mv -v ~/.ssh/config ~/.ssh/config.bak
ln -sfv $DIR/sshconfig ~/.ssh/config

read -p "Create ~/.bin?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    [[ -L "~/.bin" ]] || rm -v ~/.bin
    [[ -L "~/.bin" ]] && mv -v ~/.bin ~/.bin.bak
    ln -sfv $DIR/bin ~/.bin
    chmod -v +x $DIR/bin/*
fi

echo Installed dotfiles.
