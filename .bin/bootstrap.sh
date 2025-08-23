#!/bin/sh

git submodule init
git submodule update --init --recursive

for f in $(ls -A); do
    rsync -a --delete $f "$HOME/"
done

echo "DONE!"
