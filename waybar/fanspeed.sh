#!/bin/bash

echo -n $(ls /sys/class/hwmon/*/fan1_input | head -n 1 | xargs cat)#$(echo -e "\U000f0210") | jq -s -R --compact-output 'split("#") | { "text": .[1], "tooltip": .[0] + " RPM" }'
