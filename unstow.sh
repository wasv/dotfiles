#!/bin/env bash
if [ -z "$1" ]; then
    echo Usage: ./stow.sh \<overlay\> [target]
    exit -1
fi
DOTDIR="$(dirname $(realpath -s $0))"
PACKAGE="$1"
TARGET="$(realpath ${2:-$HOME})"

SOURCE="$DOTDIR/$PACKAGE"
echo $SOURCE

pushd $SOURCE &>/dev/null
while read -u 10 file; do
    dfile=${file/#dot-/.}
    echo FILE: $dfile
    rm -iv $TARGET/$dfile
    cp -iv $(realpath $file) $TARGET/$dfile
done 10< <(find -type f -printf '%P\n')
popd &>/dev/null
