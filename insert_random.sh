#!/bin/bash


get_batch()
{
	local n=$1
	local random
	local sql=""
	while [ "$n" -gt "0" ]; do
		random=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w "${1:-10}" | head -n 1)
		sql="$sql""INSERT INTO animals VALUES (NULL,'$random');"
		n=$((n-1))
	done

	echo "$sql"
}

while true; do
	sql=$(get_batch 10)
	echo "Do '$sql'"
	./my3306.sh -e "$sql"
	sleep 1
done

