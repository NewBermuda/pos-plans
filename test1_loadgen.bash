#!/bin/bash
local="/root/pos-plans/plans/commands"
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
mosquitto -p 1930 -v -d
# get pid
mypid=$(pidof mosquitto)
echo $mypid

pidstat -h -r -u -v -p "$mypid" 5 > $local/server_results/test1/mosquitto_$b.txt 