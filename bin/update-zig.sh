#!/bin/sh

set -e

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="zig-linux-x86_64-$1.tar.xz"

curl --fail -L -O "https://ziglang.org/download/$1/$FILENAME"

if [ -e zig.old ]; then
	rm -r zig.old
fi

if [ -e zig ]; then
	mv zig zig.old
fi

tar -xJvf "$FILENAME"

mv "zig-linux-x86_64-$1" zig

rm "$FILENAME"

zig version
