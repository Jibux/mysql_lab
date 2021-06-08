#!/bin/bash


PORT="3307"
source mysql.sh

mysql_cmd "$@"

