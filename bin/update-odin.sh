#!/bin/bash

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(odin version | grep -Eo '[0-9]{4}-[0-9]{2}' || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/odin-lang/Odin/releases/latest | jq -r '.tag_name' | grep -Eo '[0-9]{4}-[0-9]{2}')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="odin-linux-amd64-dev-$VERSION.tar.gz"

curl --fail -L -O "https://github.com/odin-lang/Odin/releases/download/dev-$VERSION/$FILENAME"

if [ -e odin.old ]; then
	rm -r odin.old
fi

if [ -e odin ]; then
	mv odin odin.old
fi

tar xzf "$FILENAME"
rm "$FILENAME"

mv odin-linux-amd64* odin

make -C "$HOME/Tools/odin/vendor/stb/src"

odin version
