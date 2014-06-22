#!/bin/bash

df | awk '
BEGIN {
	used = 0;
	free = 0;
}
NR != 1 {
	used = used + $3;
	free = free + $4;
}
END {
	print("Total space = "used+free" Ko\nUsed space = "used" Ko\nFree space = "free" Ko");
}'
