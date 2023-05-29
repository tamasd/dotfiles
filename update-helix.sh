#!/bin/sh

mkdir -p $HOME/bin
curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r '.assets[] | select(.name | contains("x86_64.AppImage")) | select(.name | contains(".zsync") | not) | .browser_download_url' | xargs curl -Lo $HOME/bin/hx
