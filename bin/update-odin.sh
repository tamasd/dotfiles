#!/bin/bash

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(odin version | egrep -o '[0-9]{4}-[0-9]{2}' || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/odin-lang/Odin/releases/latest | jq -r '.tag_name' | egrep -o '[0-9]{4}-[0-9]{2}')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="odin-ubuntu-amd64-dev-$VERSION.zip"

curl --fail -L -O "https://github.com/odin-lang/Odin/releases/download/dev-$VERSION/$FILENAME"

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
