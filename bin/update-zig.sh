#!/bin/sh

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(zig version || echo)
	LATEST_VERSION=$(curl -s https://ziglang.org/download/index.json | jq -r '[ keys_unsorted | .[] | select(. | test("[0-9]\\.[0-9]+\\.[0-9]")) ] | first')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="zig-x86_64-linux-$VERSION.tar.xz"

curl --fail -L -O "https://ziglang.org/download/$VERSION/$FILENAME"

if [ -e zig.old ]; then
	rm -r zig.old
fi

if [ -e zig ]; then
	mv zig zig.old
fi

tar -xJvf "$FILENAME"

mv "zig-x86_64-linux-$VERSION" zig

rm "$FILENAME"

zig version
