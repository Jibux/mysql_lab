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

slave_status()
{
	mysql_cmd -e "SHOW SLAVE STATUS\G"
}


init_server_uuid()
{
	SERVER_UUID=$(mysql_cmd -NB -e "select @@server-uuid")
}

init_master_uuid()
{
	MASTER_UUID=$(slave_status | grep Master_UUID | awk '{print $NF}')
}

DB_NAME="lab"
MYSQL_CLIENT_EXTRA_CNF="./my$PORT.cnf"
check_port

