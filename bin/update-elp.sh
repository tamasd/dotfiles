#!/bin/bash

set -e

VERSION="$1"
OTP_VERSION=$(cat $HOME/Tools/erlang/OTP_VERSION | grep -oP '^[\d]+\.[\d]+' || echo)

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(elp version | grep -oP '\d{4}-\d{2}-\d{2}' || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/WhatsApp/erlang-language-platform/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

RELEASE_INFO=$(curl -s https://api.github.com/repos/WhatsApp/erlang-language-platform/releases/tags/$VERSION)

FILENAME="elp-linux-x86_64-unknown-linux-gnu-otp-$OTP_VERSION.tar.gz"
if [ -z "$(echo "$RELEASE_INFO" | jq -r ".assets[].name | select(. == \"$FILENAME\")")" ]; then
  OTP_MAJOR_VERSION=$(cat $HOME/Tools/erlang/OTP_VERSION | grep -oP '^[\d]+')
  FILENAME=$(echo "$RELEASE_INFO" | jq -r ".assets[].name | select(test(\"elp-linux-x86_64-unknown-linux-gnu-otp-$OTP_MAJOR_VERSION\\\\.[0-9]+\\\\.tar\\\\.gz\"))" | sort | tail -n 1)
fi

curl --fail -L -O "https://github.com/WhatsApp/erlang-language-platform/releases/download/$VERSION/$FILENAME"

tar -xzvf "$FILENAME"

mv elp $HOME/Tools/bin/

rm "$FILENAME"
