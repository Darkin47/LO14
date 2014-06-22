#!/bin/bash

OLD_IFS=$IFS
IFS=' | '

for argument in $@; do
	regex=$(tr '[:lower:]' '[:upper:]' <<< "$argument")
	while read line; do
		array=($line)
		if [[ "${array[1]}" =~ $regex ]]; then
			echo "${array[1]} : ${array[0]}"
			break
		fi
	done < "bourse.txt"
done

IFS=$OLD_IFS

exit 0
