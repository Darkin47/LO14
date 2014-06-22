#!/bin/bash

df | awk '
BEGIN {
	used = 0
	free = 0
	indice = 0
}
NR != 1 {
	add = 1
	for(element in array) {
		if (array[element] == $1) {
			add = 0
		}
	}
	if(add) {
		array[indice]=$1
		indice++
		used += $3
		free += $4
	}
}
END {
	print("Total space = "used+free" Kio")
	print("Used space = "used" Kio")
	print("Free space = "free" Kio")
}'
