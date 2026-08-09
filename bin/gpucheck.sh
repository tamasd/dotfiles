#!/bin/bash

bold="\x1b[1m"
suspended="\x1b[90m"
reset="\x1b[0m"

declare -A vendorActiveColorMap
vendorActiveColorMap['0x10de']="\x1b[32m"
vendorActiveColorMap['0x1002']="\x1b[31m"
vendorActiveColorMap['0x8086']="\x1b[34m"

declare -A vendorNameMap
vendorNameMap['0x10de']="Nvidia"
vendorNameMap['0x1002']="Amd"
vendorNameMap['0x8086']="Intel"

echo -ne $reset

for i in /sys/class/drm/card[0-9]; do
  vendor=$(cat $i/device/vendor)
  case "$(cat $i/device/power/runtime_status)" in
    "active")
      echo -e ${vendorActiveColorMap[$vendor]}$bold${vendorNameMap[$vendor]}$reset
    ;;
    "suspended")
      echo -e $suspended${vendorNameMap[$vendor]}$reset
    ;;
  esac
done
