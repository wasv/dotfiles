#!/bin/env bash
if [ -z "$1" ]; then
    echo 'Usage: ./stow.sh (put|get|link|unlink) <overlay> [target]'
    exit -1
fi

ACTION="$1"
DOTDIR="$(dirname $(realpath -s $0))"
PACKAGE="$2"
TARGET="$(realpath ${3:-$HOME})"

SOURCE="$DOTDIR/$PACKAGE"

pushd $SOURCE &>/dev/null
while read -u 10 file; do
    dfile=${file/#dot-/.}
    echo FILE: $TARGET/$dfile
    case $ACTION in
        link)
            mkdir -pv $(dirname $TARGET/$dfile)
            ln -siv $(realpath $file) $TARGET/$dfile
            ;;
        unlink)
            rm -iv $TARGET/$dfile
            cp -v $(realpath $file) $TARGET/$dfile
            ;;
        put)
            mkdir -pv $(dirname $TARGET/$dfile)
            cp -bv $(realpath $file) $TARGET/$dfile
            ;;
        get)
            cp -v $TARGET/$dfile $(realpath $file)
            ;;
    esac
done 10< <(find -type f -printf '%P\n')
popd &>/dev/null
