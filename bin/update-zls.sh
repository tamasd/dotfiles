#!/bin/sh

set -e

mkdir -p $HOME/Tools/bin
cd $HOME/Tools

FILENAME="zls-x86_64-linux.tar.xz"

curl --fail -L -O "https://github.com/zigtools/zls/releases/download/$1/zls-x86_64-linux.tar.xz"

tar -xJvf "$FILENAME" zls

mv zls bin/

rm "$FILENAME"

zls version
