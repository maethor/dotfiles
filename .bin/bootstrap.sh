#!/bin/sh

git submodule init
git submodule update

for f in $(ls -A); do
    cp -rf $f "$HOME/"
done

echo "DONE!"
