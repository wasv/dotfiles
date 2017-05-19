echo Installing dependencies.
mkdir -pv ~/.vim/autoload/
wget -O ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo Installing dotfiles.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
ln -sfv $DIR/bashrc ~/.bashrc

mv -v ~/.emacs.d ~/.emacs.d.bak
ln -sfv $DIR/emacs.d ~/.emacs.d

ln -sfv $DIR/vimrc ~/.vimrc
mkdir -v ~/.config
ln -sfv ~/.vim ~/.config/nvim
ln -sfv ~/.vimrc ~/.config/nvim/init.vim

ln -sfv $DIR/gitconfig ~/.gitconfig
echo Installed dotfiles.
