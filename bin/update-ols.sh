#!/bin/bash

# Update tools
if test -e "$HOME/Tools/ols"; then
  echo "updating ols and odinfmt"
  (
    cd "$HOME/Tools/ols"
    git fetch --all
    LATEST_TAG=$(git tag | grep dev | sort | tail -n 1)
    CURRENT_TAG=$(git describe --tags --abbrev=0)
    if [ "$LATEST_TAG" != "$CURRENT_TAG" ]; then
      git checkout "$LATEST_TAG"
      ./build.sh
      ./odinfmt.sh
      mv ols odinfmt "$HOME/Tools/bin/"
    fi
  )
fi
