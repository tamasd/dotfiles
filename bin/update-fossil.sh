#!/bin/bash

set -e

VERSION="$1"

if [ -z "$1" ]; then
  INSTALLED_VERSION=$(fossil version | awk '{print $5}' || echo)
  LATEST_VERSION=$(curl -sL https://fossil-scm.org/ | grep -oP 'Latest Release: \K[0-9]+\.[0-9]+')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="fossil-linux-x64-$VERSION.tar.gz"

curl --fail -L -O "https://fossil-scm.org/home/uv/$FILENAME"

tar -xzf "$FILENAME"
mv fossil bin

rm "$FILENAME"

fossil version
