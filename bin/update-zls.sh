#!/bin/sh

if [ $(grep -E '^ID=' /etc/os-release | cut -d'=' -f2) == "arch" ]; then
	exit 0
fi

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(zls version || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/zigtools/zls/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools/bin
cd $HOME/Tools

FILENAME="zls-x86_64-linux.tar.xz"

curl --fail -L -O "https://github.com/zigtools/zls/releases/download/$VERSION/zls-x86_64-linux.tar.xz"

tar -xJvf "$FILENAME" zls

mv zls bin/

rm "$FILENAME"

zls version
