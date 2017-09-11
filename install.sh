echo Installing dependencies.
mkdir -pv ~/.vim/autoload/
wget -O ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo Installing dotfiles.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

read -p "Install emacs config? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv -v ~/.emacs.d ~/.emacs.d.bak
    git clone git@github.com:wastevensv/emacs.d ~/.emacs.d
fi

for p in "$DIR/patch/*.patch"
do
    cat $p
    read -p "Apply $p? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
       git apply $p
    fi
done

mv -v ~/.bin ~/.bin.bak
ln -sv $DIR/bin ~/.bin

mv -v ~/.bashrc ~/.bashrc.bak
ln -sv $DIR/bashrc ~/.bashrc

mv -v ~/.vimrc ~/.vimrc.bak
ln -sv $DIR/vimrc ~/.vimrc

mkdir -v ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

mv -v ~/.gitconfig ~/.gitconfig.bak
ln -sv $DIR/gitconfig ~/.gitconfig
echo Installed dotfiles.
