case $1 in
    put|get|link|unlink)
        ACTION="$1"
        shift
        ;;
    *)
        ACTION="put"
        ;;
esac
OVERLAYS=${@:-base zsh tmux gpg git vim nvim}

for overlay in $OVERLAYS; do
    $(dirname $0)/stow.sh $ACTION $overlay 
done
