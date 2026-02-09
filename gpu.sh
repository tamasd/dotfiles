#!/bin/bash

bold="#[bright]"
suspended="#[fg=color241]"
active="#[fg=color245]"
reset="#[none]"

declare -A vendorNameMap
vendorNameMap['0x10de']="N"
vendorNameMap['0x1002']="A"
vendorNameMap['0x8086']="I"

echo -ne $reset

for i in /sys/class/drm/card[0-9]; do
  vendor=$(cat $i/device/vendor)
  case "$(cat $i/device/power/runtime_status)" in
    "active")
      echo -ne $active$bold${vendorNameMap[$vendor]}$reset
    ;;
    "suspended")
      echo -ne $suspended${vendorNameMap[$vendor]}$reset
    ;;
  esac
done
