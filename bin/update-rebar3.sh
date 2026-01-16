#!/bin/bash

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(rebar3 -v | grep -oP '[\d\.]+' | head -n 1 || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/erlang/rebar3/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools/bin

curl -L -o $HOME/Tools/bin/rebar3 https://github.com/erlang/rebar3/releases/download/$VERSION/rebar3
chmod +x $HOME/Tools/bin/rebar3
