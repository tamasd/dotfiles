#!/bin/sh

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(glsl_analyzer --version || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/nolanderc/glsl_analyzer/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools/bin
cd $HOME/Tools

FILENAME="x86_64-linux-musl.zip"

curl --fail -L -O "https://github.com/nolanderc/glsl_analyzer/releases/download/$VERSION/x86_64-linux-musl.zip"

unzip "$FILENAME" 

glsl_analyzer version
