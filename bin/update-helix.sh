#!/bin/sh

set -e

VERSION="$1"

if [ -z "$1" ]; then
  INSTALLED_VERSION=$(hx --version | grep -oP '\d{2}\.[\d\.]+')
  LATEST_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r '.tag_name')

	if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
		VERSION="$LATEST_VERSION"
	else
		echo "versions match ($INSTALLED_VERSION == $LATEST_VERSION)"
		exit 0
	fi
fi

mkdir -p $HOME/Tools
cd $HOME/Tools

if command -v "dpkg" ; then
  curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r '.assets[] | select(.name | test("\.deb$")) | .browser_download_url' | xargs curl -Lo $HOME/Tools/helix.deb
  sudo dpkg -i $HOME/Tools/helix.deb
  rm $HOME/Tools/helix.deb
fi

