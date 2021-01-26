#!/bin/sh

for i in `ifconfig | grep -E '^\S' | awk -F '[: ]' '{print $1}' | grep -vE '(lo|docker|vboxnet|br-)'`; do
	ifconfig $i | grep 'inet ' | sed -e 's/inet addr:/inet /' | awk "{printf \"$i %s \", \$2}"
done
