#!/bin/bash

# exit on error
set -e
# log every command
set -x

if test "$#" -ne 2; then
	echo "Usage: test1.sh loadgen dut"
	exit
fi

LOADGEN=$1
DUT=$2

DIR=$(dirname $(realpath $0))
POS=pos

# start mosquitto
$POS commands launch $LOADGEN -- mosquitto -p 1930 -v -d

