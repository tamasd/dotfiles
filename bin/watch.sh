#!/bin/bash

killtree() {
	# find all descendant processes
	PIDS=$(pstree -p "$PID" | grep -o '([0-9]\+)' | grep -o '[0-9]\+' | sort -u)
	if [ -n "$PIDS" ]; then
		kill $PIDS &>/dev/null
		for i in $PIDS; do
			wait "$i" &>/dev/null
		done
	fi
}

sigint_handler() {
	killtree
	exit
}

trap sigint_handler INT

while true; do
	$@ &
	PID=$!
	inotifywait -e modify -e move -e create -e delete -e attrib -r "$(pwd)" &>/dev/null
	killtree
done
