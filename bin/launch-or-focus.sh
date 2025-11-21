#!/bin/bash

WINDOW_PATTERN="$1"
LAUNCH_COMMAND="${2:-"uwsm app -- $WINDOW_PATTERN"}"

WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg p "$WINDOW_PATTERN" '.[]|select((.class|test("\\b" + $p + "\\b";"i")) or (.title|test("\\b" + $p + "\\b";"i")))|.address')
WINDOW_COUNT=$(wc -l <<< $WINDOW_ADDRESS)

case $WINDOW_COUNT in
  0)
    eval exec $LAUNCH_COMMAND
    ;;
  1)
    hyprctl dispatch focuswindow "address:$WINDOW_ADDRESS"
    ;;
  *)
    CURRENT=$(hyprctl activewindow -j | jq -r .address)
    N=$(grep -n $CURRENT <<< $WINDOW_ADDRESS | cut -d':' -f1)
    if [[ -z $N ]]; then
      hyprctl dispatch focuswindow "address:$(head -n 1 <<< $WINDOW_ADDRESS)"
    else
      I=$(( ($N % $WINDOW_COUNT) + 1 ))
      hyprctl dispatch focuswindow "address:$(head -n +$I <<< $WINDOW_ADDRESS | tail -n 1)"
    fi
    ;;
esac
