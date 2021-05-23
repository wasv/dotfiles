for overlay in $@; do
    $(dirname $0)/stow.sh $overlay 
done
