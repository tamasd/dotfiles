#!/bin/sh

val=$(cat /sys/class/thermal/thermal_zone*/temp | sort -nr | head -n 1)

echo -e "$((val / 1000))°C"
