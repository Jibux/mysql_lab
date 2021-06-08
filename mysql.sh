#!/bin/bash


set -o errexit -o errtrace -o pipefail -o nounset


fail()
{
	echo "$1">&2
	exit 1
}

check_port()
{
	if [[ "$PORT" != "3306" && "$PORT" != "3307" ]]; then
		fail "PORT variable should be set to '3306' or '3307'"
	fi
}

mysql_cmd()
{
	mysql --defaults-extra-file="$MYSQL_CLIENT_EXTRA_CNF" -P"$PORT" "$DB_NAME" "$@"
}

DB_NAME="lab"
MYSQL_CLIENT_EXTRA_CNF="./my$PORT.cnf"
check_port

