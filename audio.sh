#!/bin/bash

echo $(LC_NUMERIC=en_US.UTF-8 pactl --format=json list sinks |
	jq -r --arg name "$(pactl get-default-sink)" '
		.[] |
		select( .name == $name ) |
		.properties."alsa.card_name" // .description') $(echo -e "\U000f1120")
