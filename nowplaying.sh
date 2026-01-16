#!/bin/bash

player=$(playerctl metadata --format '{{playerName}}')
status=$(playerctl -p "$player" status)

declare -A statusMap
statusMap['Playing']="\U000f040a"
statusMap['Paused']="\U000f03e4"
statusMap['Stopped']="\U000f04db"

echo "$player" $(echo -e ${statusMap[$status]})
