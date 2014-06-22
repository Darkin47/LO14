#!/bin/bash

while read line; do
	if [[ $(cut -d':' -f4 <<< "$line") -lt 100 ]]; then
		echo "$line"
	fi
done < "/etc/passwd"

exit 0
