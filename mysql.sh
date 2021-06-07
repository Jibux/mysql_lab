#!/bin/bash


set -o errexit -o errtrace -o pipefail -o nounset


usage()
{
	echo "$0 OPTIONS"
	echo
	echo "--port=<PORT> ('3306' or '3307')"
	echo "--setup: do the initial setup"
	echo "--exec-file=<SQL_FILE>: exec the SQL_FILE"
}

exit_usage()
{
	usage
	exit 1
}

fail()
{
	echo "$1">&2
	exit 1
}

check_port()
{
	if [[ "$PORT" != "3306" && "$PORT" != "3307" ]]; then
		exit_usage
	fi
}

mysql_init()
{
	check_port
	MYSQL="mysql --defaults-extra-file=$MYSQL_CLIENT_EXTRA_CNF -P$PORT $DB_NAME"
}

mysql_exec()
{
	$MYSQL -e "$1"
}

mysql_exec_file()
{
	local file=$1
	[ -f "$file" ] || fail "'$file' does not exist"
	$MYSQL < "$file"
}

setup()
{
	mysql_exec_file "sql/$PORT"_init.sql
}

PORT="3306"
SETUP="no"
DB_NAME="lab"
EXEC_FILE=""
EXEC=""

for arg in "$@"; do
	case $arg in
	--setup)
		SETUP="yes"
		shift
		;;
	--port=*)
		PORT="${arg#*=}"
		shift
		;;
	--exec-file=*)
		EXEC_FILE="${arg#*=}"
		shift
		;;
	--exec=*)
		EXEC="${arg#*=}"
		shift
		;;

	*)
		usage
		exit 1
		;;
	esac
done

MYSQL_CLIENT_EXTRA_CNF="./$PORT-mysql_client.cnf"
mysql_init
if [ "$SETUP" == "yes" ]; then
	setup
elif [ -n "$EXEC_FILE" ]; then
	mysql_exec_file "$EXEC_FILE"
elif [ -n "$EXEC" ]; then
	mysql_exec "$EXEC"
else
	$MYSQL
fi

