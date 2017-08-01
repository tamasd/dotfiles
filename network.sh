#!/bin/sh

for i in `ifconfig | grep -E '^\S' | cut -d':' -f1 | grep -v lo`; do
	ifconfig $i | grep 'inet ' | awk "{printf \"$i %s \", \$2}"
done
