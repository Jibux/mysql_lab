#!/bin/bash


PORT="3306"
source mysql.sh

mysql_cmd "$@"

