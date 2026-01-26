#!/bin/bash

val=$(cat /sys/class/thermal/thermal_zone*/temp | awk '$1 < 105000' | sort -nr | head -n 1)

echo -e "$((val / 1000))°C"
