#!/bin/sh

sigint_handler() {
	kill "$PID"
	exit
}

trap sigint_handler INT

while true; do
	$@ &
	PID=$!
	inotifywait -e modify -e move -e create -e delete -e attrib -r "$(pwd)"
	kill "$PID"
	sleep 1
done
