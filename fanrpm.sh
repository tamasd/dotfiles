#!/bin/bash

echo $(cat /sys/class/hwmon/*/fan1_input)$(echo -e "\U000f0210")
