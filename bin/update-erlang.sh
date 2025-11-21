#!/bin/bash

if [ $(grep -E '^ID=' /etc/os-release | cut -d'=' -f2) == "arch" ]; then
	exit 0
fi

set -e

VERSION="$1"

if [ -z "$1" ]; then
	INSTALLED_VERSION=$(cat $HOME/Tools/erlang/OTP_VERSION || echo)
	LATEST_VERSION=$(curl -s https://api.github.com/repos/erlang/otp/releases/latest | jq -r '.tag_name' | grep -oP '[\d\.]+')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

FILENAME="otp_src_$VERSION.tar.gz"

curl --fail -L -O "https://github.com/erlang/otp/releases/download/OTP-$VERSION/otp_src_$VERSION.tar.gz"

if [ -e erlang.old ]; then
  rm -r erlang.old
fi

if [ -e erlang ]; then
  mv erlang erlang.old
fi

tar -xzvf "$FILENAME"

rm "$FILENAME"

mv "otp_src_$VERSION" erlang

cd erlang
export ERL_TOP=$(pwd)

./configure --prefix=$HOME/Tools

make
make release_tests
(
  cd release/tests/test_server
  $ERL_TOP/bin/erl -s ts install -s ts smoke_test batch -s init stop
)
make install
