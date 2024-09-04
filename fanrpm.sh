#!/bin/bash

echo $(ls /sys/class/hwmon/*/fan1_input | head -n 1 | xargs cat)$(echo -e "\U000f0210")
