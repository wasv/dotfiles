#!/bin/env bash
if [ -z "$1" ]; then
    echo Usage: ./stow.sh \<overlay\> [target]
    exit -1
fi
DOTDIR="$(dirname $(realpath -s $0))"
PACKAGE="$1"
TARGET="$(realpath ${2:-$HOME})"

SOURCE="$DOTDIR/$PACKAGE"

pushd $SOURCE &>/dev/null
while read -u 10 dir; do
    ddir=${dir/#dot-/.}
    echo DIR: $TARGET/$ddir
    mkdir -pv $TARGET/$ddir
done 10< <(find -type d -printf '%P\n')
while read -u 10 file; do
    dfile=${file/#dot-/.}
    echo FILE: $TARGET/$dfile
    ln -siv $(realpath $file) $TARGET/$dfile
done 10< <(find -type f -printf '%P\n')
popd &>/dev/null
