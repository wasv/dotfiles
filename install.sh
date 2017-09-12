DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

echo Installing dependencies.
mkdir -pv ~/.vim/autoload/
wget -O ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~
f=$DIR/bin-dir.patch
cat "$f"
read -p "Apply $f? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git apply "$f"
    mv -v ~/.bin ~/.bin.bak
    ln -sv $DIR/bin ~/.bin
    chmod -v +x $DIR/bin/*
fi
cd -

echo Installing dotfiles.
read -p "Install emacs config? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv -v ~/.emacs.d ~/.emacs.d.bak
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

mv -v ~/.bashrc ~/.bashrc.bak
ln -sv $DIR/bashrc ~/.bashrc

mv -v ~/.vimrc ~/.vimrc.bak
ln -sv $DIR/vimrc ~/.vimrc

mkdir -v ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

mv -v ~/.gitconfig ~/.gitconfig.bak
ln -sv $DIR/gitconfig ~/.gitconfig

mv -v ~/.ssh/config ~/.ssh/config.bak
ln -sv $DIR/sshconfig ~/.ssh/config
echo Installed dotfiles.
