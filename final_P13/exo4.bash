#!/bin/bash

# List every files and directory of the directory
# $1 - directory path
# $2 - number of recurrences
function list {
	local -i nb_tab=$2
	while read line; do
		for (( i=0; i<=nb_tab; i++ )); do
			echo -e -n '\t'
		done
		if [[ "$line" =~ /$ ]]; then
			local directory="$(sed 's/\/$//' <<< $line)"
			echo "\-- $directory"
			list "$1/$directory" "$(($nb_tab+1))"
		else echo "+-- $line"
		fi
	done < <(ls -1p "$1")
}

list "$1" "0"

exit 0
