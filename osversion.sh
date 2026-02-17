#!/bin/bash

eval "$(cat /etc/os-release)"

#echo -ne "\U0000ebc6"
echo -ne "$ID@"
uname -r | cut -d '-' -f1
