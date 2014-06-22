#!/bin/bash

while read line; do
	if [[ "$(cut -d' ' -f2 <<< $line)" == 'Z' ]]; then
		echo "$line"
	fi
done < <(ps -el | tr -s ' ')

exit 0
