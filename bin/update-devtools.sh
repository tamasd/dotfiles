#!/bin/sh

rustup self update
rustup update
sh $HOME/dotfiles/devcontainer/post-create.sh
