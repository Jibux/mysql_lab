#!/bin/bash


./my3306.sh < sql/master_init.sql
./my3307.sh < sql/slave_init.sql

