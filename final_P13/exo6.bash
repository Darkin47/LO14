#!/bin/bash

# Return 0 if not found, 1 if found, 2 if different type.
# $1 - file or directory name
# $2 - directory path
function look_for {
	local -i code=0
	while read line; do
		if [[ "$line" == "$1" ]]; then
			code=1
			break
		elif [[ "$line/" == "$1" || "$line" == "$1/" ]]; then
			code=2
			break
		fi
	done < <(ls -1p "$2")
	echo $code
}

# Main function
# $1 - first directory path
# $2 - second directory path
function main {
	local -i code
	while read line; do
		code=$(look_for "$line" "$2")
		if [[ $code -eq 0 ]]; then
			echo "$line est seulement dans $1."
		elif [[ $code -eq 2 && $line =~ /$ ]]; then
			echo "$line est un répertoire dans $1 mais un fichier dans $2."
		elif [[ $code -eq 2 ]]; then
			echo "$line est un fichier dans $1 mais un répertoire dans $2."
		fi
	done < <(ls -1p "$1")
	while read line; do
		code=$(look_for "$line" "$1")
		if [[ $code -eq 0 ]]; then
			echo "$line est seulement dans $2."
		fi
	done < <(ls -1p "$2")
}

main "$@"
exit 0
