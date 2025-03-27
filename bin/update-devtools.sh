#!/bin/sh

rustup self update
rustup update
sh $HOME/dotfiles/devcontainer/post-create.sh

# Update tools
if test -e "$HOME/Tools/ols"; then
  echo "updating ols and odinfmt"
  (
    cd "$HOME/Tools/ols"
    git pull --no-verify-signatures
    ./build.sh
    ./odinfmt.sh
    mv ols odinfmt "$HOME/Tools/bin/"
  )
fi
