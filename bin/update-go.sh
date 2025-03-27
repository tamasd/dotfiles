#!/bin/sh

set -e

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="go$1.linux-amd64.tar.gz"

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
