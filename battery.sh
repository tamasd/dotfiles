#!/bin/bash

if ! command -v upower &>/dev/null ; then
	exit 0
fi

info="$(upower -e | grep 'DisplayDevice' | xargs upower -i)"
percentage="$(echo "$info" | grep percentage | cut -d':' -f2 | tr -d ' ')"
rate=$(echo "$info" | grep energy-rate | cut -d':' -f2 | tr -d ' ' | cut -d'W' -f1 | cut -d'.' -f1)

echo "$percentage ${rate}W"
