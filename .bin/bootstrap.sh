#!/bin/sh

git submodule init
git submodule update --init --recursive

for f in $(ls -A); do
    cp -rf $f "$HOME/"
done

echo "DONE!"
