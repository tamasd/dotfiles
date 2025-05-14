#!/bin/bash

set -e

VERSION="$1"
OTP_VERSION=$(cat $HOME/Tools/erlang/OTP_VERSION | grep -oP '^[\d]+' || echo)

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(erlang_ls -v | grep -oP '[\d\.]+' || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/erlang-ls/erlang_ls/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="erlang_ls-linux-$OTP_VERSION.tar.gz"

curl --fail -L -O "https://github.com/erlang-ls/erlang_ls/releases/download/$VERSION/$FILENAME"

tar -xzvf "$FILENAME"

rm "$FILENAME"

mv erlang_ls bin/
