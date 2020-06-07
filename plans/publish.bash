#/bin/bash
# test 1 for mosquitto
# Script for resource usages tests of mosquitto sever
# first argument is port number
# second argument is number of topics to subscribe to
# exit on error
set -e
# log every command
set -x
local="/media/sf_shared/commands"
a="$1"

while true
do
	mosquitto_pub -p $1 -h '172.16.2.1' -t 'test' -m 'hello' &
	sleep 1s 
done
kill %!

