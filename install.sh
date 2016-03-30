echo Installing dotfiles.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
ln -sfv $DIR/bashrc ~/.bashrc
ln -sfv $DIR/vimrc ~/.vimrc
ln -sfv $DIR/gitconfig ~/.gitconfig
echo Installed dotfiles.
