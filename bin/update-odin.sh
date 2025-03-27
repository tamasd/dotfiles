#!/bin/sh

set -e

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="odin-ubuntu-amd64-dev-$1.zip"

curl --fail -L -O "https://github.com/odin-lang/Odin/releases/download/dev-$1/$FILENAME"

if [ -e odin.old ]; then
	rm -r odin.old
fi

if [ -e odin ]; then
	mv odin odin.old
fi

unzip "$FILENAME"
tar xzf dist.tar.gz

mv odin-linux-amd64* odin

rm "$FILENAME"
rm dist.tar.gz

odin version
