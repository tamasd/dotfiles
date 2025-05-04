#!/bin/bash

# Update tools
if test -e "$HOME/Tools/ols"; then
  echo "updating ols and odinfmt"
  (
    cd "$HOME/Tools/ols"
    git fetch
    if [ "$(git rev-list HEAD..origin/master --count)" != "0" ]; then
      git merge --no-verify-signatures --ff origin/master
      ./build.sh
      ./odinfmt.sh
      mv ols odinfmt "$HOME/Tools/bin/"
    fi
  )
fi
