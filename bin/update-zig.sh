#!/bin/sh

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(zig version)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/ziglang/zig/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="zig-linux-x86_64-$VERSION.tar.xz"

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
