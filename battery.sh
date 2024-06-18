#!/bin/bash

if ! command -v upower &>/dev/null ; then
	exit 0
fi

upower -e | grep 'DisplayDevice' | xargs upower -i | grep percentage | cut -d':' -f2 | tr -d ' '
