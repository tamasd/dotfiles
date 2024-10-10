#!/bin/bash

status=$(playerctl status)

declare -A statusMap
statusMap['Playing']="\U000f040a"
statusMap['Paused']="\U000f03e4"
statusMap['Stopped']="\U000f04db"

echo $(playerctl metadata --format '{{playerName}}') $(echo -e ${statusMap[$status]})
