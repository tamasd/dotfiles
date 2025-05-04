#!/bin/bash

set -e

VERSION="$1"

if [ -z "$1" ]; then
  INSTALLED_VERSION=$(go version | grep -oP '1\.\d+\.\d+' || echo)
  LATEST_VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go1\.[0-9]+\.[0-9].linux-amd64.tar.gz' | head -n 1 | grep -oP '1\.\d+\.\d+')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="go$VERSION.linux-amd64.tar.gz"

curl --fail -L -O "https://go.dev/dl/$FILENAME"

if [ -e go.old ]; then
    rm -r go.old
fi

if [ -e go ]; then
    mv go go.old
fi

tar -xzvf "$FILENAME"

rm "$FILENAME"

go version
