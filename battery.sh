#!/bin/bash

if ! command -v upower &>/dev/null ; then
	exit 0
fi

export LC_ALL=C

info="$(upower -e | grep 'DisplayDevice' | xargs upower -i)"
percentage="$(echo "$info" | grep percentage | cut -d':' -f2 | tr -d ' ')"
rate=$(echo "$info" | grep energy-rate | cut -d':' -f2 | tr -d ' ' | cut -d'W' -f1 | cut -d'.' -f1)

export LC_ALL=C.UTF-8

declare -A profileMap
profileMap['power-saver']="\U000f032a"
profileMap['performance']="\U000f14de"

pp=""
if [[ -f "/etc/tuned/active_profile" && -f "/etc/tuned/ppd.conf" ]]; then
	name=$(grep $(cat /etc/tuned/active_profile) /etc/tuned/ppd.conf | cut -d'=' -f1)
	pp=$(echo -e ${profileMap[$name]})
fi

echo -e "${percentage}${pp} ${rate}W"
